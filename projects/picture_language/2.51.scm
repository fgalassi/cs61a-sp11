(define (below painter1 painter2)
  (let ((paint-bottom (transform-painter painter1
                                         (make-vect 0 0)
                                         (make-vect 1 0)
                                         (make-vect 0 0.5)))
        (paint-up (transform-painter painter2
                                     (make-vect 0 0.5)
                                     (make-vect 1 0.5)
                                     (make-vect 0 1))))
    (lambda (frame)
      (paint-bottom frame)
      (paint-up frame))))

(define (below2 painter1 painter2)
  (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))
