(define (ordered? sentence-of-numbers)
  (if (> 2 (count sentence-of-numbers))
    true
    (if (> (item 1 sentence-of-numbers) (item 2 sentence-of-numbers))
      false
      (ordered? (butfirst sentence-of-numbers)))))
