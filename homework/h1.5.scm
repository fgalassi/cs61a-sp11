; > (ends-e ’(please put the salami above the blue elephant))
; (please the above the blue)
;

(define (ends-e phrase)
  (if (empty? phrase)
    '()
    (sentence (word-ends-e (first phrase)) (ends-e (butfirst phrase)))))

(define (word-ends-e w)
  (if (equal? (last w) 'e)
    w
    '()))

