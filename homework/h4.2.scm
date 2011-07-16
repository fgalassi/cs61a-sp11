(define (substitute2 seq old-words new-words)
  (cond ((word? seq)
         (substitute-words seq old-words new-words))
        ((list? seq) (map (lambda (seq) (substitute2 seq old-words new-words)) seq))))

(define (substitute-words wd old-words new-words)
  (if (null? old-words)
    wd
    (if (equal? wd (car old-words))
      (car new-words)
      (substitute-words wd (cdr old-words) (cdr new-words)))))

