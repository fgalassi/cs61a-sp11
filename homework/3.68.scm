(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x)) t)
   (pairs (stream-cdr s) (stream-cdr t))))

; (pairs integers integers)
;
; leads to infinite recursion on the pairs function



