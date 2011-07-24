(define (map-1 fn args)
  (if (null? args)
    '()
    (cons (apply-1 fn (list (car args))) (map-1 fn (cdr args)))))
