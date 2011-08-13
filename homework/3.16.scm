(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))

; returns 
; -> [1|*] -> [2|*] -> [3|/]
(define a1 (list 1 2 3))

; returns 4
; -> [1|*] -> [*|*]
;              | |
;              v v
;             [3|/]
(define b2 (cons 3 nil))
(define a2 (cons 1 (cons b2 b2)))

; returns 7
; -> [*|*]
;     | |
;     v v
;    [*|*]
;     | |
;     v v
;    [3|/]
(define c3 (cons 3 nil))
(define b3 (cons c3 c3))
(define a3 (cons b3 b3))

; never returns
; -> [1|*] -> [2|*] -> [*|/]
;     ^                 |
;     |                 |
;     -------------------
(define a4 (list 1 2 3))
(set-car! (cddr a4) a4)
