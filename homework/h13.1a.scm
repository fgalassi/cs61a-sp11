(load "localmr")

(define (inverted-index dir)
  (lmapreduce
    (lambda (kv)
      (map
        (lambda (value) (cons value (kv-key kv)))
        (kv-value kv)))
    cons
    '()
    dir))
