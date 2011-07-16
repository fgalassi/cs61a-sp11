(define (reckless strategy)
  (define (hit? hand dealer-card) (strategy hand dealer-card))
  (define (previous-hit? hand dealer-card)
    (and
      (not (empty? hand))
      (strategy (butlast hand) dealer-card)))
  (lambda (hand dealer-card) (or (hit? hand dealer-card) (previous-hit? hand dealer-card)))) 

