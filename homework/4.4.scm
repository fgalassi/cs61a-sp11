(load "4.3")

(define (eval-and exp env)
  (if (null? (cdr exp))
    #t
    (let ((first (mc-eval (cadr exp) env))
          (rest (cddr exp)))
      (cond ((false? first) #f)
            ((and (true? first) (null? rest)) first)
            (else (eval-and rest env))))))

(define (eval-or exp env)
  (if (null? (cdr exp))
    #f
    (let ((first (mc-eval (cadr exp) env))
          (rest (cdr exp)))
      (cond ((true? first) first)
            (else (eval-or rest env))))))

(mc-put 'and eval-and)
(mc-put 'or eval-or)
