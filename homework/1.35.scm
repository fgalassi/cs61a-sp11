(define tolerance 0.00001)
(define (close-enough? neg pos) (< (abs (- pos neg)) tolerance))

(define (fixed-point f first-guess)
  (let ((new-guess (f first-guess)))
    (if (close-enough? new-guess first-guess)
      new-guess
      (fixed-point f new-guess))))

(define (golden)
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))
