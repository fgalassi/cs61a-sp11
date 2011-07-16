(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map
                       (lambda (subset) (cons (car s) subset))
                       rest)))))

;(define (subsets s)
  ;(accumulate
    ;(lambda (elem subs) (append (map (lambda (sb) (cons elem sb)) subs) subs))
    ;'(())
    ;s))

; (1 2 3)
; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
