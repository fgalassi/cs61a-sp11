;(define coins '(50 25 10 5 1))
(define coins '(5 1))

(define (count-change amount)
  (cc amount coins))

(define (cc amount coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (empty? coins)) 0)
        ((> amount 0)
         (+ (cc amount (butfirst coins))
            (cc (- amount (first coins)) coins)))))

(define (cc2 amount coins)
  (cond ((or (< amount 0) (empty? coins)) 0)        
        ((= amount 0) 1)
        ((> amount 0)
         (+ (cc amount (butfirst coins))
            (cc (- amount (first coins)) coins)))))

; (cc  0 '()) -> 1
; (cc2 0 '()) -> 0 
