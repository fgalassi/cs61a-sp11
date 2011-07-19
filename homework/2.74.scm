(define (install-division1-file)
  (define (get-record file employee-name) ...)
  (put 'division1 'get-record get-record))

(define (get-record file employee-name)
  ((get (division file) 'get-record) file employee-name))

(define (make-file division content) (attach-tag name content))
(define (division file) (type-tag file))
(define (content file) (contents file))


