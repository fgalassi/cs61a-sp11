(load "load-simply")
(load "majority-strategy")
(load "assert")

(define (hit hand dealer-card) #t)
(define (stand hand dealer-card) #f)

(assert equal? ((majority-strategy stand stand stand) '() 'as) #f "#f #f #f -> #f")
(assert equal? ((majority-strategy hit stand stand) '() 'as) #f "#t #f #f -> #f")
(assert equal? ((majority-strategy hit hit stand) '() 'as) #t "#t #t #f -> #t")
(assert equal? ((majority-strategy hit hit hit) '() 'as) #t "#t #t #t -> #t")


(display "done.\n")
(quit)
