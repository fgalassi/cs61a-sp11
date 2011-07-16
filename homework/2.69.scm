;; EXERCISE 2.69

(load "huffman")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (if (= (count leaf-set) 1)
    (car leaf-set)
    (successive-merge (adjoin-set
                        (make-code-tree (car leaf-set) (cadr leaf-set))
                        (cddr leaf-set)))))
