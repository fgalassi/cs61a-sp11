(define (count-frac-rec n d k)
  (if (= k 0)
    0
    (/ (n k) (+ (d k) (count-frac n d (- k 1))))))

(define (count-frac-iter n d k)
  (define (iter n d k result)
    (if (= k 0)
      result
      (iter n d (- k 1) (/ (n k) (+ (d k) result)))))
  (iter n d k 0))

(define (approx-rec k)
  (count-frac-rec (lambda (i) 1.0) (lambda (i) 1.0) k))

(define (approx-iter k)
  (count-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) k))

; for recursive solution k is evaluated in reverse. it doesnt matter since n and d return always 1.0
; for 4 decimal places k > 10
