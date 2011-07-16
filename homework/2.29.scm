;(define (make-mobile left right)
  ;(list left right))

;(define (make-branch length structure)
  ;(list length structure))

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define left-branch car)
;(define right-branch cadr)
(define right-branch cdr)

(define branch-length car)
;(define branch-structure cadr)
(define branch-structure cdr)

(define weight? number?)

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (weight? structure)
      structure
      (total-weight structure))))

(define (balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and
      (= (torque left) (torque right))
      (balanced-branch? left)
      (balanced-branch? right))))

(define (torque branch)
  (* (branch-length branch) (branch-weight branch)))

(define (balanced-branch? branch)
  (let ((structure (branch-structure branch)))
    (or (weight? structure) (balanced? structure))))

(define m1
  (make-mobile
    (make-branch 10 (make-mobile
                      (make-branch 9 10)
                      (make-branch 11 (make-mobile
                                        (make-branch 12 11)
                                        (make-branch 7 8)))))
    (make-branch 5 58)))

(define m-balanced
  (make-mobile
    (make-branch 4 (make-mobile
                     (make-branch 5 4)
                     (make-branch 10 2)))
    (make-branch 3 8)))
