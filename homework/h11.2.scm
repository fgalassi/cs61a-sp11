(define (fract-stream fraction)
  (let ((numerator (car fraction))
        (denominator (cadr fraction)))
    (cons-stream
      (div (* numerator 10) denominator)
      (fract-stream (list (remainder (* numerator 10) denominator) denominator)))))

(define (approximation fraction-stream precision)
  (if (= precision 0)
    '()
    (cons
      (stream-car fraction-stream)
      (approximation (stream-cdr fraction-stream) (- precision 1)))))
