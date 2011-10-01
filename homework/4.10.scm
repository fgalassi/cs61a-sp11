(load "mceval")

;(if expr then stuff else stuff)

(define (if-consequent exp) (cadddr exp))
(define (if-alternative exp)
  (if (eq? 'else (list-ref exp 4))
      (list-ref exp 5)
      'false))
(define (make-if predicate consequent alternative)
  (list 'if predicate 'then consequent 'else alternative))
