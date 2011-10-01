(load "mceval")
(load "tables")

(define mc-table (make-table))
(define (mc-get name) (lookup name mc-table))
(define (mc-put name operation) (insert! name operation mc-table))

(define (installed exp) (mc-get (car exp)))
(define (installed? exp) (and (pair? exp) (installed exp)))

(mc-put 'quote  (lambda (exp env) (text-of-quotation exp)))
(mc-put 'set!   (lambda (exp env) (eval-assignment exp env)))
(mc-put 'define (lambda (exp env) (eval-definition exp env)))
(mc-put 'if     (lambda (exp env) (eval-if exp env)))
(mc-put 'lambda (lambda (exp env) (make-procedure
                                        (lambda-parameters exp)
                                        (lambda-body exp) env)))
(mc-put 'begin  (lambda (exp env) (eval-sequence (begin-actions exp) env)))
(mc-put 'cond   (lambda (exp env) (mc-eval (cond->if exp) env)))

(define (mc-eval exp env)
  (cond ((self-evaluating? exp) exp)
	((variable? exp) (lookup-variable-value exp env))
  ((installed? exp) ((installed exp) exp env))
	((application? exp)
	 (mc-apply (mc-eval (operator exp) env)
		   (list-of-values (operands exp) env)))
	(else
	 (error "Unknown expression type -- EVAL" exp))))

