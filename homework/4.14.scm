(define (map func lst)
  (if (null? lst)
    '()
    (cons (func (car lst)) (cdr lst))))

; when map is installed as a primitive, the evaluation doesnt work it tries to
; call system map with a compound procedure object as parameter
; when map is typed into the evaluator everything is ok
