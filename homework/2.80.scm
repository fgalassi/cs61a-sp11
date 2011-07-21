; scheme-number package
(define (=zero-scheme-number? x) (= x 0))
; ...
(put '=zero? '(scheme-number) =zero-scheme-number?)

; rational package
(define (=zero-rational? x) (= (numer x) 0))
; ...
(put '=zero? '(rational) =zero-rational?)

; complex package
(define (=zero-complex? x) (and (= (real-part x) 0) (= (imag-part x) 0))
; ...
(put '=zero? '(complex) =zero-complex?)

; make global
(define (=zero? x) (apply-generic '=zero? x))
