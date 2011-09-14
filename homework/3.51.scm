(define (show x) (display x) x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
; 0x

(stream-ref x 5)
; 123455

(stream-ref x 7)
; 677
