(load "higher-order")

(define (best-total hand)
  (let ((total (bt hand 0)))
    (if (> total 21)
      999
      total)))

(define (bt hand total)
  (if (empty? hand)
    total
    (let* ((current-card (first hand))
           (current-card-points (card-points current-card))
           (next-hand (butfirst hand)))
      (cond ((empty? hand) total)
            ((> total 21) total)
            ((card-ace? current-card)
             (max-less-than-21
               (bt next-hand (+ total 1))
               (bt next-hand (+ total 11))))
            ((card-joker? current-card)
             (max-less-than-21
               (bt next-hand (+ total 1))
               (bt next-hand (+ total 2))
               (bt next-hand (+ total 3))
               (bt next-hand (+ total 4))
               (bt next-hand (+ total 5))
               (bt next-hand (+ total 6))
               (bt next-hand (+ total 7))
               (bt next-hand (+ total 8))
               (bt next-hand (+ total 9))
               (bt next-hand (+ total 10))
               (bt next-hand (+ total 11))))
            (else
              (bt next-hand (+ total current-card-points)))))))

(define (max-less-than-21 . numbers)
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

(define (card-points card)
  (cond ((card-joker? card) 11)
        ((card-ace? card) 11)
        ((card-face? card) 10)
        (else (card-value card))))

(define (card-value card)
  (butlast card))

(define (card-ace? card)
  (equal? (card-value card) 'a))

(define (card-face? card)
  (member? (card-value card) '(j q k)))

(define (card-joker? card)
  (equal? card 'jr))
