(define (map func sent)
  (if (empty? sent)
    '()
    (sentence (func (first sent)) (map func (butfirst sent)))))

(define (reduce total func sent)
  (if (empty? sent)
    total
    (reduce (func total (first sent)) func (butfirst sent))))

(define (filter pred sent)
  (if (empty? sent)
    '()
    (if (pred (first sent))
      (sentence (first sent) (filter pred (butfirst sent)))
      (filter pred (butfirst sent)))))

(define (any? pred sent)
  (cond ((empty? sent) #f)
        ((pred (first sent)) #t)
        (else (any? pred (butfirst sent)))))

(define (compose func1 func2)
  (lambda (x) (func1 (func2 x))))

(define (sum numbers)
  (reduce 0 + numbers))

