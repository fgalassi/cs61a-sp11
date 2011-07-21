; integer package
(define (make-rational numer denom) ((get 'make-rational 'rational) numer denom)
(define (integer->rational n) (make-rational n 1))
; ...
(put 'raise '(integer) integer->rational)

; rational package
(define (make-real val) ((get 'make-real 'real) val)
(define (rational->real n) (make-real (/ (numer n) (denom n))))
; ...
(put 'raise '(rational) rational->real)

; real package
(define (make-complex-from-real-imag real imag)
  ((get 'make-complex-from-real-imag 'complex) real imag))
(define (real->complex n) (make-complex-from-real-imag n 0))
; ...
(put 'raise '(real) real->complex)

; global
(define (raise n) (apply-generic 'raise n))
