(load "higher-order")

(define (best-total hand)
  (let* ((total-non-aces (sum (map value-of-card (non-aces hand))))
         (total (add-n-aces-to (count (aces hand)) total-non-aces)))
    (if (valid-total? total)
      total
      0)))

(define (valid-total? total)
  (<= total 21))

(define (value-of-card card)
  (let ((value (butlast card)))
    (cond ((member? value '(j q k))
          10)
          ((equal? value 'a)
          11)
          (else value))))

(define (add-n-aces-to number-of-aces total)
  (let ((highest-total (+ total (* number-of-aces 11))))
    (if (or (valid-total? highest-total) (= 0 number-of-aces))
      highest-total
      (add-n-aces-to (- number-of-aces 1) (+ total 1)))))

(define (non-aces cards)
  (filter (compose not ace?) cards))

(define (aces cards)
  (filter ace? cards))

(define (ace? card)
  (equal? (butlast card) 'a))

(define (compose func1 func2)
  (lambda (x) (func1 (func2 x))))
