(load "higher-order")

(define (suit-strategy suit has-suit-strategy hasnt-suit-strategy)
  (lambda (hand dealer-card)
    (if (suit-in-hand? suit hand)
      (has-suit-strategy hand dealer-card)
      (hasnt-suit-strategy hand dealer-card))))

(define (suit? suit)
  (lambda (card) (equal? (last card) suit)))

(define (suit-in-hand? suit hand)
  (any? (suit? suit) hand))
