(define (crx-function wd)
  (let ((body (butfirst (butlast wd))))
    (crx-body body)))

(define (crx-body body)
  (if (empty? body)
    identity
    (cond ((equal? (first body) 'a) (compose (crx-body (butfirst body)) car))
          ((equal? (first body) 'd) (compose (crx-body (butfirst body)) cdr))
          (else (error "invalid char")))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (identity x) x)

(define fecar (crx-function 'car))
(fecar (list 1 2 3 4))
; 1
(define fecdr (crx-function 'cdr))
(fecdr (list 1 2 3 4))
; (2 3 4)
(define fecadr (crx-function 'cadr))
(fecadr (list (list 5 6 7 8) 2 3 4))
; (6 7 8)
(define fecdar (crx-function 'cdar))
(fecdar (list 1 2 3 4))
; 2
(define fecaadr (crx-function 'caadr))
(fecaadr (list (list (list 10 11 12) 6 7 8) 2 3 4))
; (11 12)
