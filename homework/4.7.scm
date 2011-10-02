(load "4.6")

(define (make-let bindings body)
  (list 'let bindings body))

(define (let*->nested-lets exp)
  (define (expand-let* bindings body)
    (if (null? bindings)
      body
      (make-let
        (list (car bindings))
        (expand-let* (cdr bindings) body))))
  (expand-let* (let-bindings exp) (let-body exp)))

(define (eval-let* exp env)
  (mc-eval (let*->nested-lets exp) env))

(mc-put 'let* eval-let*)
