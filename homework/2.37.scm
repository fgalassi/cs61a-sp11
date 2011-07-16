(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (mrow) (dot-product v mrow)) m))

(define (transpose mat)
  (accumulate-n
    (lambda (elem lst) (cons elem lst))
    '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (mrow) (matrix-*-vector cols mrow)) m)))

