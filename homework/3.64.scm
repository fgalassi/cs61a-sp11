(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)

(define (stream-cadr s) (stream-car (stream-cdr s)))

(define (stream-limit s tolerance)
  (cond ((stream-null? (stream-cdr s)) (stream-car s))
        ((> tolerance (abs (- (stream-cadr s) (stream-car s)))) (stream-cadr s))
        (else (stream-limit (stream-cdr s) tolerance))))


(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
