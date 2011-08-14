(define (make-deque) (cons '() '()))
(define (empty-deque? d) (not (deque-node? (front-node d))))

(define (front-deque d)
  (if (empty-deque? d)
    #f
    (deque-node-val (front-node d))))
(define (rear-deque d)
  (if (empty-deque? d)
    #f
    (deque-node-val (rear-node d))))
(define (front-insert-deque! d item)
  (let ((new-node (make-deque-node item '() '())))
    (if (empty-deque? d)
      (begin
        (set-front-node! d new-node)
        (set-rear-node! d new-node))
      (begin
        (set-deque-node-next! new-node (front-node d))
        (set-deque-node-prev! (front-node d) new-node)))
        (set-front-node! d new-node))
  'ok)

(define (rear-insert-deque! d item)
  (let ((new-node (make-deque-node item '() '())))
    (if (empty-deque? d)
      (begin
        (set-front-node! d new-node)
        (set-rear-node! d new-node))
      (begin
        (set-deque-node-prev! new-node (rear-node d))
        (set-deque-node-next! (rear-node d) new-node)))
        (set-rear-node! d new-node))
  'ok)

(define (front-delete-deque! d)
  (if (empty-deque? d)
    #f
    (begin
      (set-front-node! d (deque-node-next (front-node d)))
      (if (deque-node? (front-node d))
        (set-deque-node-prev! (front-node d) '())
        (set-rear-node! d '()))
      'ok)))

(define (rear-delete-deque! d)
  (if (empty-deque? d)
    #f
    (begin
      (set-rear-node! d (deque-node-prev (rear-node d)))
      (if (deque-node? (rear-node d))
        (set-deque-node-next! (rear-node d) '())
        (set-front-node! d '()))
      'ok)))

(define (front-node d) (car d))
(define (rear-node d) (cdr d))
(define (set-front-node! d new) (set-car! d new))
(define (set-rear-node! d new) (set-cdr! d new))

(define (make-deque-node val prev next)
  (cons (cons val prev) next))
(define (deque-node? n) (pair? n))
(define (deque-node-val n) (caar n))
(define (deque-node-prev n) (cdar n))
(define (deque-node-next n) (cdr n))
(define (set-deque-node-val! n new) (set-car! (car n) new))
(define (set-deque-node-prev! n new) (set-cdr! (car n) new))
(define (set-deque-node-next! n new) (set-cdr! n new))
