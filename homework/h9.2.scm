(define (vector-filter pred? vec)
  (define (loop-count n)
    (cond ((< n 0) 0)
          ((pred? (vector-ref vec n)) (+ 1 (loop-count (- n 1))))
          (else (loop-count (- n 1)))))
  (define (loop-filter newvec n i)
    (cond ((< n 0) newvec)
          ((pred? (vector-ref vec n))
                  (vector-set! newvec i (vector-ref vec n))
                  (loop-filter newvec (- n 1) (- i 1)))
          (else (loop-filter newvec (- n 1) i))))
  (let ((num-filtered (loop-count (- (vector-length vec) 1))))
    (let ((newvec (make-vector num-filtered)))
      (loop-filter newvec (- (vector-length vec) 1) (- (vector-length newvec) 1)))))

; same running time O(n) with version doing conversion from/to list and using
; list filter

