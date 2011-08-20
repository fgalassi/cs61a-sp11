(define x 10)
(define s (make-serializer))
(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
                  (s (lambda () (set! x (+ x 1)))))

; a1 => ((s (lambda () (* x x))))  a2 => set! x a1
; b1 => (s (lambda () (set! x (+ x 1))))
;
; a1  a2  b1
; 10  100 101
; a1  b1  a2
; 10  11  100
; b1  a1  a2
; 11  11  121
;
; 100, 101, 121
