(define (double func)
  (lambda (x) (func (func x))))

(define (inc x) (+ x 1))

(define (inc2 x) ((double inc) x))
