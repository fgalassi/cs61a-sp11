(define (square x) (* x x))

; lambda solution
(define (repeated func n)
  (if (= n 1)
    (lambda (x) (func x))
    (lambda (x) ((repeated func (- n 1)) (func x)))))

; compose solution
(define (repeated func n)
  (if (= n 1)
    (compose func identity)
    (compose (repeated func (- n 1)) func)))

(define (identity x) x)

(define (compose f g)
  (lambda (x) (f (g x))))
