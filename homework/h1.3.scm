(define (switch phrase)
  (switch-phrase phrase true))

(define (switch-phrase phrase start?)
  (if (empty? phrase)
    '()
    (sentence (switch-word (first phrase) start?) (switch-phrase (butfirst phrase) false))))

(define (switch-word w start?)
  (cond ((equal? w 'i)  'you)
        ((equal? w 'me) 'you)
        ((and start? (equal? w 'you)) 'i)
        ((equal? w 'you) 'me)
        (else w)))
