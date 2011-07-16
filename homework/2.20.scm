(define (same-parity . seq)
  (filter (lambda (n) (= (remainder n 2) (remainder (car seq) 2))) seq))
