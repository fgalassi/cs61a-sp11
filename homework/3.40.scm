(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))

; a1 => x;  a2 => x;  a3 => * a1 a2;  a4 => !set x a3
; b1 => x;  b2 => x;  b3 => x; b4 => * b1 b2 b3; b5 => set! x b4 
;
; the minimum is 100
; a1 a2 a3 b1...b5 a4
;
; the maximum is 1000000
; a1...a4 b1...b5
;
; a result x must be x = 10^n with 2 <= n <= 5
;
; 1000
; b1 b2 b3 b4 a1...a4 b5
;
; 10000
; b1 b2 a1...a4 b3...b5
;
; 100000
; b1 a1..a4 b2..b5
;
; so 100 1000 10000 1000000


(define x 10)
(parallel-execute (s lambda () (set! x (* x x)))
                  (s lambda () (set! x (* x x x))))

; result can be 100^3 or 1000^2 which is always 1000000
