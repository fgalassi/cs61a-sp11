(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

; (factorial 5) in applicative order?
;
; it grows the stack indefinitely because it calculates (factorial (- n 1)) before checking the
; condition so it goes (fac 5) (fac 4) (fac 3) (fac 2) (fac 1) (fac 0) (fac -1) (fac - 2) ...etc...
; until it crashes
