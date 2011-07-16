(define (substitute seq old-word new-word)
  (cond ((word? seq)
         (if (equal? seq old-word) new-word seq))
        ((list? seq) (map (lambda (seq) (substitute seq old-word new-word)) seq))))
