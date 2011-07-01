(load "best-total")

(define (dealer-sensitive hand dealer-card)
  (let ((player-points (best-total hand))
        (dealer-points (card-points dealer-card)))
    (or
      (and (> dealer-points 6) (< player-points 17))
      (and (<= dealer-points 6) (< player-points 12)))))
