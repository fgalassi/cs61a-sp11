(load "best-total")

(define (valentine-strategy hand dealer-card)
  (let ((player-points (best-total hand)))
    (or
      (and (has-hearts? hand) (< player-points 19))
      (< player-points 17))))


(define (has-hearts? hand)
  (any? (lambda (card) (heart? card)) hand))

(define (heart? card)
  (equal? (last card) 'h))
