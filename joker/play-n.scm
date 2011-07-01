(load "twenty-one")

(define (play-n strategy n)
  (if (= n 0)
    0
    (+ (twenty-one strategy) (play-n strategy (- n 1)))))

