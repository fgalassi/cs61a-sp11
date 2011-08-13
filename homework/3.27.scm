(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value) (cdr table)))))
  'ok)

(define (make-table)
  (list '*table*))

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

; Explain why memo-fib computes nth fibonacci number in a number of steps
; proportional to n:
;
; Because fib(n) is defined in terms of summations of fib(n - x) with x <= 6.
; This means there are n possible arguments passed to fib. Each time an argument
; is passed to fib it's memoized and never calculated again. Memoization takes
; O(1) hence n times O(1) = O(n)
;
; Would the scheme still work if we had simply defined memo-fib to be (memoize
; fib)?
;
; No, because only fib(n) would be memoized, not fib(n - x) with x < 6, hence
; memo-fib would still take O(2^n)
;
