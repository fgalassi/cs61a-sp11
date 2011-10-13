(define (analyze-sequence exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs)) ((car procs) env))
          (else ((car procs) env)
                (execute-sequence (cdr procs) env))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (lambda (env) (execute-sequence procs env))))

; Consider the common case where the sequence has just one expression. What work
; will the execution procedure produced by Alyssa's program do?
;
; it will check if the it's the only procedure in the sequence and then execute
; it
;
; What about the execution procedure produced by the program in the text above?
;
; it will just execute the procedure
;
; How do the two versions compare for a sequence with two expressions?
;
; Alyssa's will check if the procedure is the only one then it will execute it
; and recursively check the second and execute it
; Original's will just execute the two procedures
;
; In general original's approach does "analyze more", Alyssa's less but it's
; correct anyway.
