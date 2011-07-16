(define (product a b term next)
  (if (> a b)
    1
    (* (term a) (product (next a) b term next))))

(define (factorial n)
  (define (identity x) x)
  (define (following x) (+ x 1))
  (product 1 n identity following))

(define (wallis-pi n)
  (define (following x) (+ x 1))
  (define (wallis-term k)
    (let ((numerator
            (if (even? k)
              (+ k 2)
              (+ k 1)))
          (denominator
            (if (even? k)
              (+ k 1)
              (+ k 2))))
    (/ numerator denominator)))
  (* 4 (product 1 n wallis-term following)))
