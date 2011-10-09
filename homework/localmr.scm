#|

Three steps of map reduce:

1. apply mapper to each kv pair in input..
2. sort them into buckets  (sort-into-buckets)
3. run a reduce on each bucket (groupreduce)

This version internally operates on association lists, and
converts to and from stream as necesary to match the real
mapreduce.

NOTE: use this file for testing locally to weed out trivial errors. You will not
be able to answer parallelization questions just by using this code.

USAGE:
(lmapreduce <mapper> <reducer> <base-case> <input>)
<input> is either a stream of key-value pairs, or:
"/sample-emails" - a bunch of emails keyed by a single key, sample-emails
"/beatles-songs" - beatles song titles keyed by album
These are NOT the same as what the real mapreduce uses (obviously, much smaller)
|#

;; kv-pair abstraction
(define make-kv-pair cons)
(define kv-key car)
(define kv-value cdr)

;; Load data
(load "localmr-beatles.scm")
(load "localmr-emails.scm")

;; lmapreduce is like mapreduce, but local. So far can only handle input:
; 1. /sample-emails   very small email sample (see small reader for format)
; 2. /beatles-songs   beatles song titles keyed by album
; 3. a stream of key-value pairs
(define (lmapreduce mapper reducer base-case input)
  (cond ((equal? input "/beatles-songs")
	 (local-map-reduce mapper reducer base-case beatles-songs))
	((equal? input "/sample-emails")
	 (local-map-reduce mapper reducer base-case sample-emails))
	(else
	 (local-map-reduce mapper reducer base-case (stream->list input)))))
	 

;; input to mapreduce is a STREAM of key-value pairs.
;;   internally uses lists, and converts back to stream at the end.
(define (local-map-reduce mapper reducer base-case input)
  (list->stream (groupreduce (sort-into-buckets (flatmap mapper input)) reducer base-case)))


; Bucket ADT
; a bucket looks like ( key .  <values>)
(define (make-bucket key) (list key))
(define (bucket-key bucket) (car bucket))
(define (add-to-bucket! bucket value) (set-cdr! bucket (cons value (cdr bucket))))

;; not in any order whatsoever.. just go through all of them, and
;; put them into buckets.
;; returns a LIST of BUCKETS sorted by key
;;  if both keys are numbers, it will use <= as
;;  a comparator, otherwise it will use string<=?
(define (sort-into-buckets kv-pairs)
  (let ((buckets nil))  ;; a list of buckets
    (for-each (lambda (kvp)
		(let ((bucket (assoc (kv-key kvp) buckets)))
		  (if bucket (add-to-bucket! bucket (kv-value kvp))
		      (let ((new-bucket (make-bucket (kv-key kvp))))
			(add-to-bucket! new-bucket (kv-value kvp))
			(set! buckets (cons new-bucket buckets))))))
	      kv-pairs)
    (sort buckets (lambda (b1 b2)
		    (let ((k1 (bucket-key b1))
			  (k2 (bucket-key b2)))
		      (if (and (number? k1) (number? k2))
			  (<= k1 k2)
			  (string<=? (word->string k1)
				     (word->string k2))))) )))

;; accumulates for every bucket
(define (groupreduce buckets reducer base-case)
  (map (lambda (kvp)
	 (cons (kv-key kvp)
	       (accumulate reducer base-case (kv-value kvp))))
       buckets))

;; for finite streams       
(define (stream->list S)
  (if (stream-null? S) nil
      (cons (stream-car S) (stream->list (stream-cdr S)))))


