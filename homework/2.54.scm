(define (equal? first second)
  (cond ((and (list? first) (list? second)) (or
                         (and (null? first) (null? second))
                         (and (equal? (car first) (car second)) (equal? (cdr first) (cdr second)))))
        ((and (symbol? first) (symbol? second)) (eq? first second))
        (else #f)))
