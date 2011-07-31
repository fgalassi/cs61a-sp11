(define (plus1 var)
  (set! var (+ var 1))
  var)

; (plus 5)
; (set! 5 (+ 5 1))
; error
;
; scheme with environment model would give 6
