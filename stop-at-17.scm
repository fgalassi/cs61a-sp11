(load "best-total")

(define (stop-at-17 hand dealer-card)
  (< (best-total hand) 17))

