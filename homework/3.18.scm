(define has-cycle?
  (let ((seen '()))
    (lambda (lst)
      (cond ((null? lst) #f)
            ((memq lst seen) #t)
            (else (begin
                    (set! seen (cons lst seen))
                    (has-cycle? (cdr lst))))))))
