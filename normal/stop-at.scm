(load "best-total")

(define (stop-at n)
  (lambda (hand dealer-card)
    (< (best-total hand) n)))
