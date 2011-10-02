(load "mceval")

(define (check-types vars vals env)
  (for-each (lambda (var val)
              (if (and
                    (pair? var)
                    (not (mc-apply (mc-eval (car var) env) (list val))))
                (error "Wrong argument type " val)))
            vars
            vals))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals base-env) base-env)
      (if (< (length vars) (length vals))
        (error "Too many arguments supplied" vars vals)
        (error "Too few arguments supplied" vars vals))))

(define (make-frame variables values env)
  (check-types variables values env)
  (cons
    (map (lambda (var)
           (if (pair? var)
             (cadr var)
             var))
         variables)
    values))

(define (mc-apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters procedure)
             arguments
             (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))
