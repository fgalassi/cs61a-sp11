(define (iterative-improve good-enough? improve)
  (define (itimp guess)
    (if (good-enough? guess)
      guess
      (itimp (improve guess))))
  itimp)

(define (square x) (* x x))

(define (sqrt x)
  ((iterative-improve
    (lambda (guess)
      (< (abs (- (square guess) x)) 0.001))
    (lambda (guess)
      (average guess (/ x guess))))
   1))

(define (average x y)
  (/ (+ x y) 2))
