; unless as a special form
;
; ((unless? exp) (mc-eval (unless->if exp) env))

(define (unless-condition exp) (cadr exp)
(define (unless-usual-value exp) (caddr exp)
(define (unless-exceptional-value exp) (cadddr exp)

(define (unless->if exp)
  (list
    'if
    (unless-condition exp)
    (unless-exceptional-value exp)
    (unless-usual-value exp)))

; when is unless useful as a normal procedure?
;
; can't imagine anything really useful
