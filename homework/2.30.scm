(define (square num) (* num num))

;(define (square-tree tree)
  ;(if (not (pair? tree))
    ;(square tree)
    ;(map square-tree tree)))

(define (square-tree tree)
  (cond ((not (list? tree)) (square tree))
        ((null? tree) '())
        (else (cons (square-tree (car tree)) (square-tree (cdr tree))))))

(define t1
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))
