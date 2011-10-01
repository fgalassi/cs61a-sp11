(load "4.3")

(define (let-bindings exp) (cadr exp))
(define (let-body exp) (caddr exp))

(define (binding-variable binding) (car binding))
(define (binding-exp binding) (cadr binding))

(define (let->combination exp)
  (cons
    (make-lambda
      (map binding-variable (let-bindings exp))
      (list (let-body exp)))
    (map binding-exp (let-bindings exp))))

(define (eval-let exp env)
  (mc-eval (let->combination exp) env))

(mc-put 'let eval-let)
