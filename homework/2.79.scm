
; scheme-number package
(define (equ?-scheme-number x y) (= x y))
; ...
(put 'equ? '(scheme-number scheme-number) equ?-scheme-number)

; rational package
(define (equ?-rat x y) (and (= (numer x) (numer y)) (= (denom x) (denom y))))
; ...
(put 'equ? '(rational rational) equ?-rat)

; complex package
(define (equ?-complex x y) (and (= (imag-part x) (imag-part y)) (= (real-part x) (real-part y))))
; ...
(put 'equ? '(complex complex) equ?-complex)

; make global
(define (equ? x y) (apply-generic 'equ? x y))
