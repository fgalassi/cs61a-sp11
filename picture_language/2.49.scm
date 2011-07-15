(define outline-painter
  (segments->painter
    (list
      (make-segment (make-vector 0 0) (make-vector 1 0))
      (make-segment (make-vector 1 0) (make-vector 1 1))
      (make-segment (make-vector 1 1) (make-vector 0 1))
      (make-segment (make-vector 0 1) (make-vector 0 0)))))

(define x-painter
  (segments->painter
    (list
      (make-segment (make-vector 0 0) (make-vector 1 1))
      (make-segment (make-vector 0 1) (make-vector 1 0)))))

(define diamond-painter
  (segments->painter
    (list
      (make-segment (make-vector 0.5 0) (make-vector 1 0.5))
      (make-segment (make-vector 1 0.5) (make-vector 0.5 1))
      (make-segment (make-vector 0.5 1) (make-vector 0 0.5))
      (make-segment (make-vector 0 0.5) (make-vector 0.5 0)))))

(define wave
  (segments->painter
    (list
      (make-segment (make-vector 0.354 0.000) (make-vector 0.284 0.124))
      (make-segment (make-vector 0.284 0.124) (make-vector 0.367 0.300))
      (make-segment (make-vector 0.367 0.300) (make-vector 0.279 0.300))
      (make-segment (make-vector 0.279 0.300) (make-vector 0.114 0.346))
      (make-segment (make-vector 0.114 0.346) (make-vector 0.000 0.172))
      (make-segment (make-vector 0.000 0.295) (make-vector 0.118 0.480))
      (make-segment (make-vector 0.118 0.480) (make-vector 0.273 0.373))
      (make-segment (make-vector 0.273 0.373) (make-vector 0.325 0.425))
      (make-segment (make-vector 0.325 0.425) (make-vector 0.232 1.000))
      (make-segment (make-vector 0.388 1.000) (make-vector 0.453 0.664))
      (make-segment (make-vector 0.453 0.664) (make-vector 0.576 1.000))
      (make-segment (make-vector 0.710 1.000) (make-vector 0.533 0.539))
      (make-segment (make-vector 0.533 0.539) (make-vector 1.000 0.740))
      (make-segment (make-vector 1.000 0.607) (make-vector 0.611 0.305))
      (make-segment (make-vector 0.611 0.305) (make-vector 0.535 0.305))
      (make-segment (make-vector 0.535 0.305) (make-vector 0.586 0.125))
      (make-segment (make-vector 0.586 0.125) (make-vector 0.507 0.000)))))

