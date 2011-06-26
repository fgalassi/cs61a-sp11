(load "load-simply")
(load "valentine-strategy")

(define (assert comparison actual expected msg)
  (if (not (comparison actual expected))
    (display (format #f "ERROR! ~S: actual ~A expected ~A\n" msg actual expected))))

(assert equal? (valentine-strategy '(10s 6s) 'as) #t "less than 17 always hits")
(assert equal? (valentine-strategy '(10s 7h) 'as) #t "17 hits with hearts")
(assert equal? (valentine-strategy '(10s 8h) 'as) #t "18 hits with hearts")
(assert equal? (valentine-strategy '(10s 7c) 'as) #f "17 stands without hearts")
(assert equal? (valentine-strategy '(10s 9h) 'as) #f "19 always stands")

(display "done.\n")
(quit)
