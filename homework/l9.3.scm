; 3a.
(define list1 (list (list 'a) 'b))
; list1
(define list2 (list (list 'x) 'y))
; list2
(set-cdr! (car list1) (list 'x 'b))
; okay
(set-cdr! (car list2) (list 'b))
; okay
; list1
; ((a x b) b)
; list2
; ((x b) y)

; 3b.
(set-car! (cdr list1) (cadr list2))

; list1 -> [*|*] -> [y|/]
;           |
;           v
;          [a|*] -> [x|*] -> [b|/]
;
; ((a x b) y)
