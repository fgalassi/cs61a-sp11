(define (last-pair seq)
  (cond ((null? seq) (error "empty list"))
        ((null? (cdr seq)) seq)
        (else (last-pair (cdr seq)))))
