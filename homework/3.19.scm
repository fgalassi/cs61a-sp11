(define (cycle? lst)
  (define (iter fast slow)
    (cond ((not (pair? fast)) #f)
          ((not (pair? (cdr fast))) #f)
          ((eq? fast slow) #t)
          (else (iter (cddr fast) (cdr slow)))))
  (if (null? lst)
    #f
    (iter (cdr lst) lst)))
