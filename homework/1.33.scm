(define (filtered-accumulate filter combiner null-value a b term next)
  (if (> a b)
    null-value
    (if (filter a)
      (combiner (term a) (filtered-accumulate filter combiner null-value (next a) b term next))
      (filtered-accumulate filter combiner null-value (next a) b term next))))

(define (identity x) x)
(define (following x) (+ x 1))

(define (square x) (* x x))

(define (sum-of-squares-of-primes a b)
  (filtered-accumulate prime? + 0 a b square following))

(define (product-of-positive-integers-relatively-prime-less-than n)
  (define (relatively-prime-to-n? a)
    (relatively-prime? n a))
  (filtered-accumulate relatively-prime-to-n? * 1 1 n identity following))


(define (relatively-prime? a b)
  (define (gcd a b)
    (if (= b 0)
      a
      (gcd b (modulo a b))))
  (= (gcd a b) 1))


(define (prime? n)
  (define (sub1 n) (- n 1))
  (define (is-not-divisible-by<=i i m)
    (cond
      ((= i 1) true)
      (else (cond
        ((= (remainder m i) 0) false)
        (else (is-not-divisible-by<=i (sub1 i) m))))))
  (if (< n 2)
    false
    (is-not-divisible-by<=i (sub1 n) n)))
