(define (install-division1-package)
  (define (get-record file employee-name) ...)
  (define (get-salary employee-record) ...)
  (put '(division1 file) 'get-record get-record)
  (put '(division1 record) 'get-salary get-salary)

(define (get-record file employee-name)
  ((get (list (division file) 'file) 'get-record) (content file) employee-name))

(define (get-salary employee-record)
  ((get (list (division file) record) 'get-salary) employee-record))

(define (make-file division content) (attach-tag name content))
(define (division file) (type-tag file))
(define (content file) (contents file))

(define (find-employee-record employee-name files)
  (if (null? files)
    (error "employee record not found")
    (let ((current-record (get-record (car files) employee-name)))
      (if (current-record)
        current-record
        (find-employee-record employee-name (cdr files))))))

; to add a new division
; give division an identifier and install a package
