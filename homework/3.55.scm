(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))
(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (partial-sums s)
  (if (stream-null? s)
    0
    (begin
      (define sums (cons-stream (stream-car s) (stream-map + (stream-cdr s) sums)))
      sums
    )))

