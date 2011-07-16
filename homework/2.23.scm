(define (for-each fn lst)
  (if (null? lst)
    #t
    (and (fn (car lst)) (for-each fn (cdr lst)))))
