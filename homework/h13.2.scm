(load "localmr")
(load "tables.scm")

(define (spammers n)
  (let ((common-emails (most-common (subject-occurrences "/sample-emails") n)))
    (stream->list
      (lmapreduce
        (lambda (kv)
          (let ((subject (list-ref (kv-value kv) 2))
                (from (list-ref (kv-value kv) 0)))
            (list (make-kv-pair from subject))))
        (lambda (value memo)
          (if (member? value common-emails)
            (+ memo 1)
            memo))
        0
        "/sample-emails"))))


(define (subject-occurrences emails)
  (lmapreduce
    (lambda (kv)
      (let ((subject (list-ref (kv-value kv) 2)))
        (list (make-kv-pair subject 1))))
    +
    0
    emails))

(define (most-common occurrences n)
  (first-n-elements
    (reverse
      (flatmap
        identity
        (stream->list 
          (lmapreduce
            (lambda (kv) (list (make-kv-pair (kv-value kv) (kv-key kv))))
            cons
            '()
            occurrences))))
    n))

(define (first-n-elements lst n)
  (if (or (eq? n 0) (null? lst))
    '()
    (cons (car lst) (first-n-elements (cdr lst) (- n 1)))))
