(define (assert comparison actual expected msg)
  (if (not (comparison actual expected))
    (display (format #f "ERROR! ~S: actual ~A expected ~A\n" msg actual expected))))

