(define (number-of-partitions n)
  (define (nop n numbers)
    (cond ((= n 0) 1)
          ((or (< n 0) (= numbers 0)) 0)
          ((> n 0) (+ (nop n (- numbers 1)) (nop (- n numbers) numbers)))))
  (nop n n))

; Counting partitions is like making change, where coins are "the nonnegative
; numbers equal or less than n"
;

