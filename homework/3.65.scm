(define (partial-sums s)
  (if (stream-null? s)
    0
    (begin
      (define sums (cons-stream (stream-car s) (stream-map + (stream-cdr s) sums)))
      sums
    )))

(define (ln2-summands n)
  (cons-stream (/ 1.0 n) (stream-map - (ln2-summands (+ n 1)))))

(define ln2-stream (partial-sums (ln2-summands 1)))

; it converges sloooow
