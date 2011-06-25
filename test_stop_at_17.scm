(load "load-simply")
(load "stop_at_17")

(define (assert comparison actual expected msg)
  (if (not (comparison actual expected))
    (display (format #f "ERROR! ~S: actual ~A expected ~A\n" msg actual expected))))

(assert equal? (stop-at-17 '() 'as) #t "empty hand -> #t")
(assert equal? (stop-at-17 '(2s) 'as) #t "2s -> #t")
(assert equal? (stop-at-17 '(10s 6s) 'as) #t "10s 6s -> #t")
(assert equal? (stop-at-17 '(10s 7s) 'as) #f "10s 7s -> #f")
(assert equal? (stop-at-17 '(as 5s) 'as) #t "as 5s -> #t") 
(assert equal? (stop-at-17 '(as 6s) 'as) #f "as 6s -> #f") 
(assert equal? (stop-at-17 '(3s 4s 5s as) 'as) #t "3s 4s 5s as -> #t") 

(display "done.\n")
(quit)
