(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

; mistery reverses a list with mutation

(define v (list 'a 'b 'c 'd))
; v => (a b c d)
; v -> [a|*] -> [b|*] -> [c|*] -> [d|/]

(define w (mystery v))
; v => (a)
; w => (d c b a)
;
; w -> [d|*] -> [c|*] -> [b|*] -> [a|/]
;                                  ^ 
;                                  |
; v -------------------------------

