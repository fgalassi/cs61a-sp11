;(define (sum a b term next)
;  (if (> a b)
;    0
;    (+ (term a) (sum (next a) b term next))))
;
;(define (product a b term next)
;  (if (> a b)
;    1
;    (* (term a) (product (next a) b term next))))

(define (accumulate combiner null-value a b term next)
  (if (> a b)
    null-value
    (combiner (term a) (accumulate combiner null-value (next a) b term next))))

(define (sum a b term next)
  (accumulate + 0 a b term next))

(define (product a b term next)
  (accumulate * 1 a b term next))

(define (identity x) x)
(define (following x) (+ x 1))

(define (sum-int n)
  (sum 0 n identity following))

(define (factorial n)
  (product 1 n identity following))
