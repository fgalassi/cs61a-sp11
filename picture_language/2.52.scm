(load "vect")
(load "segment")
(load "frame")
(load "picture")

(define wave
  (segments->painter
    (list
      (make-segment (make-vect 0.354 1.000) (make-vect 0.284 0.876))
      (make-segment (make-vect 0.284 0.876) (make-vect 0.367 0.700))
      (make-segment (make-vect 0.367 0.700) (make-vect 0.279 0.700))
      (make-segment (make-vect 0.279 0.700) (make-vect 0.114 0.654))
      (make-segment (make-vect 0.114 0.654) (make-vect 0.000 0.828))
      (make-segment (make-vect 0.000 0.705) (make-vect 0.118 0.520))
      (make-segment (make-vect 0.118 0.520) (make-vect 0.273 0.627))
      (make-segment (make-vect 0.273 0.627) (make-vect 0.325 0.575))
      (make-segment (make-vect 0.325 0.575) (make-vect 0.232 0.000))
      (make-segment (make-vect 0.388 0.000) (make-vect 0.453 0.336))
      (make-segment (make-vect 0.453 0.336) (make-vect 0.576 0.000))
      (make-segment (make-vect 0.710 0.000) (make-vect 0.533 0.461))
      (make-segment (make-vect 0.533 0.461) (make-vect 1.000 0.260))
      (make-segment (make-vect 1.000 0.393) (make-vect 0.611 0.695))
      (make-segment (make-vect 0.611 0.695) (make-vect 0.535 0.695))
      (make-segment (make-vect 0.535 0.695) (make-vect 0.586 0.875))
      (make-segment (make-vect 0.586 0.875) (make-vect 0.507 1.000))
      (make-segment (make-vect 0.370 0.897) (make-vect 0.400 0.897))
      (make-segment (make-vect 0.465 0.897) (make-vect 0.495 0.897))
      (make-segment (make-vect 0.440 0.840) (make-vect 0.440 0.810))
      (make-segment (make-vect 0.386 0.747) (make-vect 0.449 0.717))
      (make-segment (make-vect 0.449 0.717) (make-vect 0.502 0.750)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (beside
        (below painter painter)
        (below painter (corner-split painter (- n 1))))))
