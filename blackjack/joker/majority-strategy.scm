(load "higher-order")

; NB: bool-num and 1 are used because apparently you can't have a sentence of
; booleans so i am tricking it into a sequence of binary digits

(define (majority-strategy first-strategy second-strategy third-strategy)
  (lambda (hand dealer-card)
    (majority-of? 1 (sentence
                      (bool-num (first-strategy hand dealer-card))
                      (bool-num (second-strategy hand dealer-card))
                      (bool-num (third-strategy hand dealer-card))))))

(define (bool-num bool)
  (if bool 1 0))

(define (count-equal-to elem sent)
  (reduce 0
          (lambda (total current-elem)
            (if (equal? elem current-elem)
              (+ 1 total)
              total))
          sent))

(define (majority-of? elem sent)
  (> (count-equal-to elem sent) (/ (count sent) 2)))
