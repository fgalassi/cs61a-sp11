(define (make-segment start-vector end-vector)
  (list start-vector end-vector))

(define (start-segment segment) (car segment))

(define (end-segment segment) (cadr segment))
