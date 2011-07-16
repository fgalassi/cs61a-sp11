(define (every action phrase)
  (if (empty? phrase)
    '()
    (sentence (action (first phrase)) (every action (butfirst phrase)))))
