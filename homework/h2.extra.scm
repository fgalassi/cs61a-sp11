(
 (lambda (fact)
   (fact 5 fact)
 )
 (lambda (n self)
   (if (= n 0)
     1
     (* n (self (- n 1) self))
   )
 )
)
