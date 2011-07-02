(load "higher-order")

(define (best-total hand)
  (let ((total (bt hand 0)))
    (if (> total 21)
      999
      total)))

(define (bt hand total)
  (if (empty? hand)
    total
    (let ((current-card (first hand)) (next-hand (butfirst hand)))
      (max-less-than-21
        (map (try-bt-with-points next-hand total) (card-possible-points current-card))))))

(define (card-possible-points card)
  (cond ((card-joker? card) '(1 2 3 4 5 6 7 8 9 10 11))
        ((card-ace? card) '(1 11))
        (else (sentence (normal-card-points card)))))

(define (try-bt-with-points hand total)
  (lambda (points) (bt hand (+ total points))))

(define (max-less-than-21 numbers)
  (let ((numbers-less-than-21 (filter less-than-21? numbers)))
    (cond ((empty? numbers) 0)
          ((empty? numbers-less-than-21) (max-number numbers))
          (else (max-number numbers-less-than-21)))))

(define (less-than-21? num)
  (<= num 21))

(define (max-number numbers)
  (reduce
    0
    (lambda (total num) (max num total))
    numbers))

(define (normal-card-points card)
  (if (card-face? card) 10 (card-value card)))

(define (card-value card)
  (butlast card))

(define (card-ace? card)
  (equal? (card-value card) 'a))

(define (card-face? card)
  (member? (card-value card) '(j q k)))

(define (card-joker? card)
  (equal? card 'jr))
