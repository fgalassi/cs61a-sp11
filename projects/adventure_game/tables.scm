;;; Section 3.3.3 -- Tables

;;; One-dimensional tables

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if (not record)
        #f
        (cdr record))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if (not record)
        (set-cdr! table
                  (cons (cons key value) (cdr table)))
        (set-cdr! record value)))
  'ok)

(define (make-table)
  (list '*table*))
