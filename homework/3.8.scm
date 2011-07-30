(define f (lambda (n) (set! f (lambda (n) 0)) n))
; > (+ (f 0) (f 1))
; 0
; > (define f (lambda (n) (set! f (lambda (n) 0)) n))
; f
; > (+ (f 1) (f 0))
; 1
