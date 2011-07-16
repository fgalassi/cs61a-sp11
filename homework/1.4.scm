(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; if b > 0  return a + b
; if b <= 0 return a - b
;
; that is, always add the absolute value of b
