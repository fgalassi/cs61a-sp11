(load "mceval")

(define run
  (let ((global (setup-environment)))
    (lambda (exp) (mc-eval exp global))))

(define (test-mceval)
  (load "mceval")
  (run
    '(define (factorial n)
       (if (= n 1)
         1
         (* n (factorial (- n 1))))))
  (time (dotimes (a 1000) (run '(factorial 50)))))

(define (test-analyze)
  (load "analyze")
  (run
    '(define (factorial n)
       (if (= n 1)
         1
         (* n (factorial (- n 1))))))
  (time (dotimes (a 1000) (run '(factorial 50)))))

; (test-mceval)
;;    Time: 31716.67ms
;; GC time: 11250.00ms
;;   Cells: 190958868
; okay
;
; (test-analyze)
;;    Time: 19383.33ms
;; GC time: 7600.00ms
;;   Cells: 116807917
; okay
;
; Analysis:  39%
; Execution: 61%
