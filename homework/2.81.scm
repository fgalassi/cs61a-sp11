; a)
; an infinite loop, because at every step arguments are coerced to themselves
; so apply-generic is re-invoked with identical signature
;
; b)
; apply-generic works correctly because coercion of two arguments of the same
; type can only happen if there's no available implementation of the operation
; for those 2 types, so an error had to be returned anyway.
;
; c)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (not (eq? type1 type2))
                  (let ((t1->t2 (get-coercion type1 type2))
                        (t2->t1 (get-coercion type2 type1)))
                    (cond (t1->t2
                            (apply-generic op (t1->t2 a1) a2))
                          (t2->t1
                            (apply-generic op a1 (t2->t1 a2)))
                          (else
                            (error "No method for these types"
                                (list op type-tags)))))
                  (error "Cannot coerce same type: " type1)))
              (error "No method for these types"
                     (list op type-tags)))))))
