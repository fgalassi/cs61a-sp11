; balance is 100
; a)
(set! balance (+ balance 10))
; b)
(set! balance (- balance 20))
; c)
(set! balance (- balance (/ balance 2)))

; a.
;
; a, b, c
; b, a, c => 45
;
; a, c, b => 35
; b, c, a => 50
;
; c, a, b
; c, b, a => 40

; b.
;
; a1 => balance; a2 => inc balance 10
; b1 => balance; b2 => dec balance 20
; c1 => balance; c2 => div balance 2; c3 => balance; c4 => dec balance (half of balance)
;
; a1  b1  b2 a2  c... 
; 100 100 80 110   55
;
; a1  b1  c1  a2  b2  c...
; 100 100 100 100 80    30
