(load "load-simply")
(load "suit-strategy")
(load "stop-at")

(define (assert comparison actual expected msg)
  (if (not (comparison actual expected))
    (display (format #f "ERROR! ~S: actual ~A expected ~A\n" msg actual expected))))

(define (valentine-strategy hand dealer-card)
  ((suit-strategy 'h (stop-at 19) (stop-at 17)) hand dealer-card))

(assert equal? (valentine-strategy '(10s 6s) 'as) #t "less than 17 always hits")
(assert equal? (valentine-strategy '(10s 7h) 'as) #t "17 hits with hearts")
(assert equal? (valentine-strategy '(10s 8h) 'as) #t "18 hits with hearts")
(assert equal? (valentine-strategy '(10s 7c) 'as) #f "17 stands without hearts")
(assert equal? (valentine-strategy '(10s 9h) 'as) #f "19 always stands")

(display "done.\n")
(quit)
