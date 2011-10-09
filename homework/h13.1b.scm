(load "localmr")

(define (inverted-index dir min-length)
  (lmapreduce
    (lambda (kv)
      (map
        (lambda (value) (cons value (kv-key kv)))
        (filter
          (lambda (value) (>= (count value) min-length))
          (kv-value kv))))
    cons
    '()
    dir))

; (inverted-index "/beatles-songs" 3)
