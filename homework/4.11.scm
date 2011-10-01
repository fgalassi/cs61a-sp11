(load "mceval")

(define (make-frame variables values)
  (map (lambda (var val) (cons var val)) variables values))

(define (frame-bindings frame) frame)

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons (cons var val) (car frame))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan bindings)
      (let ((var-binding (assoc var bindings)))
        (if var-binding
          (cdr var-binding)
          (env-loop (enclosing-environment env)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-bindings frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan bindings)
      (let ((var-binding (assoc var bindings)))
        (if var-binding
          (set-cdr! var-binding val)
          (env-loop (enclosing-environment env)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-bindings frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan bindings)
      (let ((var-binding (assoc var bindings)))
        (if var-binding
          (set-cdr! var-binding val)
          (add-binding-to-frame! var val env))))
    (scan (frame-bindings frame))))
