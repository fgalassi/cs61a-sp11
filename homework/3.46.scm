(define (test-and-set! cell)
  (if (car cell)
    true
    (begin (set-car! cell true)
           false)))

; PROCESS 1                        MUTEX     PROCESS 2
; test-and-set! cell               false
; (if (car cell)                   false
;                                  false     test-and-set! cell
;                                  false     (if (car cell)
; (begin (set-car! cell true)      true
;        false)))                  true
;        <RETURN FALSE>            true
;                                  true      (begin (set-car! cell true)
;                                  true             false)))
;                                  true             <RETURN FALSE>
