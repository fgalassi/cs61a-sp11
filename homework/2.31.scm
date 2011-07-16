(define (square num) (* num num))

(define (tree-map fn tree)
  (if (not (list? tree))
    (fn tree)
    (map (lambda (subtree) (tree-map fn subtree)) tree)))

(define (square-tree tree)
  (tree-map square tree))

(define t1
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))
