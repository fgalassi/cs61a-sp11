(load "obj")

(define-class (miss-manners obj)
  (method (please meth arg)
    (ask obj meth arg)))
