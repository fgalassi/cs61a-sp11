(define count-pairs
  (let ((seen '()))
    (lambda (x)
      (cond ((not (pair? x)) 0)
            ((memq x seen) 0)
            (else (begin
                    (set! seen (cons x seen))
                    (+
                      (count-pairs (car x))
                      (count-pairs (cdr x))
                      1)))))))


(define a1 (list 1 2 3))


(define b2 (cons 3 nil))
(define a2 (cons 1 (cons b2 b2)))

(define c3 (cons 3 nil))
(define b3 (cons c3 c3))
(define a3 (cons b3 b3))

(define a4 (list 1 2 3))
(set-car! (cddr a4) a4)
