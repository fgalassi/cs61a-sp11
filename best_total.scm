(load "higher-order")

(define (best-total hand)
  (let* ((total-non-aces (sum (map card-points (non-aces hand))))
         (total (add-n-aces-to (count (aces hand)) total-non-aces)))
    (if (valid-total? total)
      total
      0)))

(define (valid-total? total)
  (<= total 21))

(define (card-points card)
    (cond ((face-card? card) 10)
          ((ace? card) 11)
          (else (card-value card))))

(define (card-value card)
  (butlast card))

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
  (equal? (card-value card) 'a))

(define (face-card? card)
  (member? (card-value card) '(j q k)))
