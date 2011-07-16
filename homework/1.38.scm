(define (count-frac n d k)
  (define (iter n d k result)
    (if (= k 0)
      result
      (iter n d (- k 1) (/ (n k) (+ (d k) result)))))
  (iter n d k 0))

(define (approx k)
  (count-frac (lambda (i) 1.0) (lambda (i) 1.0) k))

(define (euler-seq x)
  (let ((next (+ x 1)))
  (cond ((< x 3) x)
        ((= (remainder next 3) 0) (* (/ next 3) 2))
        (else 1))))

(define (euler-frac k)
  (+ 2 (count-frac (lambda (i) 1.0) euler-seq k)))
