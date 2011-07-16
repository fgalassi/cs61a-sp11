(define (make-center-percent center percent)
  (make-interval
    (* center (/ (+ 100 percent) 100))
    (* center (/ (- 100 percent) 100))))

(define (center x)
  (/ (+ (lower-bound x) (upper-bound x)) 2))

(define (percent x)
  (* 100 (- (/ (upper-bound x) (center x)) 1)))

