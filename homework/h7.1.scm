(load "obj.scm")

(define-class (random-generator range)
  (instance-vars (counter 0))
  (method (number)
    (set! counter (+ counter 1))
    (random range)))
