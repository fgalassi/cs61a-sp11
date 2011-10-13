(load "analyze")

(define (let? exp) (tagged-list? exp 'let))
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

(define (mc-eval exp env)
  (cond ((self-evaluating? exp) exp)
	((variable? exp) (lookup-variable-value exp env))
	((quoted? exp) (text-of-quotation exp))
	((assignment? exp) (eval-assignment exp env))
	((definition? exp) (eval-definition exp env))
	((if? exp) (eval-if exp env))
	((lambda? exp)
	 (make-procedure (lambda-parameters exp)
			 (lambda-body exp)
			 env))
	((begin? exp) 
	 (eval-sequence (begin-actions exp) env))
	((cond? exp) (mc-eval (cond->if exp) env))
  ((let? exp) (mc-eval (let->combination exp) env))
	((application? exp)
	 (mc-apply (mc-eval (operator exp) env)
		   (list-of-values (operands exp) env)))
	(else
	 (error "Unknown expression type -- EVAL" exp))))
