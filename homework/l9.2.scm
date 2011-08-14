(define x (cons 1 3))
(define y 2) 

; instead of (set-cdr! x y)
(set! (cdr x) y)

; gives error. why?
;
; because (cdr x) is 3, not a variable
