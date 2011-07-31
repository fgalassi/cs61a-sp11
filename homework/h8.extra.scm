(define unique-name
  (let ((counter 0))
    (lambda ()
      (set! counter (+ counter 1))
      (word 'g counter))))

(define (unique-rename expr)
  (rename expr '()))

(define (unique-vars vars)
  (map (lambda (var) (list var (unique-name))) vars))

(define (lookup name vars)
  (let ((var-found (assoc name vars)))
    (if var-found
      (cadr var-found)
      name)))

(define (rename expr vars)
  (cond ((symbol? expr) (lookup expr vars))
        ((atom? expr) expr)
        ((eq? (car expr) 'lambda)
         (let ((new-vars (unique-vars (cadr expr))))
           (list 'lambda (map cadr new-vars) (rename (caddr expr) (append new-vars vars)))))
        (else (map (lambda (subexpr) (rename subexpr vars)) expr))))

; > (unique-rename '(lambda (x) (lambda (y) (x (lambda (x) (y x))))))
; (lambda (g1) (lambda (g2) (g1 (lambda (g3) (g2 g3)))))
