(load "load-simply")
(load "reckless")
(load "assert")

(define (always-hit hand dealer-card) #t)
(define (always-stand hand dealer-card) #f)
(define (hit-on-empty-hand hand dealer-card) (empty? hand))

(assert equal? ((reckless always-hit) '() 'as) #t "hit if the original strategy hits (empty hand)")
(assert equal? ((reckless always-hit) '(10s 10c 10h) 'as) #t "hit if the original strategy hits (busting hand)")
(assert equal? ((reckless always-stand) '() 'as) #f "stand if the original strategy stands and there was no previous turn")
(assert equal? ((reckless hit-on-empty-hand) '(10c) 'as) #t "hit if the original strategy stands and previous turn it hit")
(assert equal? ((reckless always-stand) '(10c) 'as) #f "stand if the original strategy stands and previous turn it didnt hit")

(display "done.\n")
(quit)

