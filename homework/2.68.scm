;; EXERCISE 2.68

(load "huffman")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol sym tree)
  (let ((left (left-branch tree)) (right (right-branch tree)))
    (cond ((branch-has-symbol? sym left)  (cons 0 (encode-symbol-branch sym left)))
          ((branch-has-symbol? sym right) (cons 1 (encode-symbol-branch sym right)))
          (else (error "Symbol not found: " sym)))))

(define (encode-symbol-branch sym branch)
  (if (leaf? branch)
    '()
    (encode-symbol sym branch)))

(define (branch-has-symbol? sym branch)
  (member? sym (symbols branch)))
