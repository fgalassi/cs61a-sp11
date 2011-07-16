(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))

(test 0 (p))

; p is a function infinitely recursive
;
; applicative-order
; (test 0 (p)) -> (p) immediately executed , program hangs forever
;
; normal-order
; (test 0 (p))
; (if (= 0 0)
; 0 -> returns 0
