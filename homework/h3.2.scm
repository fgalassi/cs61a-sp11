(define (filter sent test?)
  (if (empty? sent)
    '()
    (if (test? (first sent))
      (sentence (first sent) (filter (butfirst sent) test?))
      (filter (butfirst sent) test?))))

(define (upto start end)
  (if (> start end)
    '()
    (sentence start (upto (+ start 1) end))))

(define (is_divisor_of? n)
  (lambda (m) (= (remainder n m) 0)))

(define (factors n)
  (filter (upto 1 (- n 1)) (is_divisor_of? n)))

(define (sum sent)
  (if (empty? sent)
    0
    (+ (first sent) (sum (butfirst sent)))))

(define (sum-of-factors n)
  (sum (factors n)))

(define (perfect? n)
  (= (sum-of-factors n) n))

(define (next-perf n)
  (if (perfect? n) n (next-perf (+ n 1))))

; STk> (next-perf 29)
; k496
;
; complexity: factors -> O(mn) with m being the number of numbers from n to the
; next-perf and n being 1..m. Pratically it's O(n**2)
;
