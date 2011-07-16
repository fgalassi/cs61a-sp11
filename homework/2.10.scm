(define (div-interval x y)
  (if (spans-zero? y)
    (error "invalid division by 0")
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y))))))

(define (spans-zero? x)
  (and (<= (lower-bound x) 0) (>= (upper-bound x) 0)))
