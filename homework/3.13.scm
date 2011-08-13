(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

; -> [a|*] -> [b|*] -> [c|*]-
;      ^                     |
;      |                     |
;       ---------------------
;
; (last-pair z) generates an infinite loop

