(define (make-table) (list '*table*))
(define (lookup keys table)
  (cond ((null? keys) (car table))
        (else (let ((subtable (assoc (car keys) (cdr table))))
                (if subtable
                  (lookup (cdr keys) (cdr subtable))
                  #f)))))

(define (insert! keys value table)
  (if (null? keys)
    (set-car! table value)
    (let ((subtable (assoc (car keys) (cdr table))))
      (if (not subtable)
        (begin
          (set-cdr! table (cons (list (car keys) #f) (cdr table)))
          (set! subtable (cadr table))))
      (insert! (cdr keys) value (cdr subtable)))))
