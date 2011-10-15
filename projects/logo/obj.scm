;;; obj.scm version 4.0 5/18/2000
;;; -- implementation of the object-oriented syntax
;; By Matt Wright, based on a handout from MIT
;; Revised for STk by Brian Gaeke - removed scm and procedure->macro

;;; Utilities

;; MAKNAM: create a new symbol whose name is the concatenation of the 
;; names of those in the symbol list SYMBOLS.
(define (maknam . symbols)
  (string->symbol (apply string-append (map symbol->string symbols))))

;; ASK: send a message to an object

; The dot in the first line of the definition of ASK, below, makes it
; take a variable number of arguments.  The first argument is associated
; with the formal parameter OBJECT; the second with MESSAGE; any extra
; actual arguments are put in a list, and that list is associated with
; the formal parameter ARGS.  (If there are only two actual args, then
; ARGS will be the empty list.)

; APPLY takes two arguments, a procedure and a list, and applies the
; procedure to the things in the list, which are used as actual
; argument values.

(define (ask object message . args)
  (let ((method (object message)))
    (if (method? method)
	(apply method args)
	(error "No method " message " in class " (cadr method)))))

(define (no-method name)
  (list 'no-method name))

(define (no-method? x)
  (if (pair? x)
      (eq? (car x) 'no-method)
      #f))

(define (method? x)
  (not (no-method? x)))


;; INSTANTIATE and INSTANTIATE-PARENT:  Create an instance of a class

; The difference is that only INSTANTIATE initializes the new object

(define (instantiate class . arguments)
  (let ((new-instance (apply (class 'instantiate) arguments)))
    (ask new-instance 'initialize new-instance)
    new-instance))

(define (instantiate-parent class . arguments)
  (apply (class 'instantiate) arguments))

;; GET-METHOD: Send a message to several objects and return the first
;; method found (for multiple inheritance)

(define (get-method give-up-name message . objects)
  (if (null? objects)
      (no-method give-up-name)
      (let ((method ((car objects) message)))
	(if (method? method)
	    method
	    (apply get-method (cons give-up-name
				    (cons message (cdr objects)) ))))))



;; USUAL: Invoke a parent's method
;; Note: The 'send-usual-to-parent method is put in automatically by
;; define-class.

(define-macro (usual . args)
	     `(ask dispatch 'send-usual-to-parent . ,args))


;; DEFINE-CLASS:  Create a new class.

; DEFINE-CLASS is a special form.  When you type (define-class body...)
; it's as if you typed (make-definitions (quote body...)).  In other
; words, the argument to DEFINE-CLASS isn't evaluated.  This makes sense
; because the argument isn't Scheme syntax, but rather is the special
; object-oriented programming language we're defining.
; Make-definitions transforms the OOP notation into a standard Scheme
; expression, then uses EVAL to evaluate the result.  (You'll see EVAL
; again in chapter 4 with the metacircular evaluator.)

; When you define a class named THING, for example, two global Scheme
; variables are created.  The variable THING has as its value the
; procedure that represents the class.  This procedure is invoked by
; INSTANTIATE to create instances of the class.  A second variable,
; THING-DEFINITION, has as its value the text of the Scheme expression
; that defines THING.  This text is used only by SHOW-CLASS, the
; procedure that lets you examine the result of the OOP-to-Scheme
; translation process.

(define-macro (define-class . body) (make-definitions body))

(define (make-definitions form)
  (let ((definition (translate form)))
    (eval `(define ,(maknam (class-name form) '-definition) ',definition))
    (eval definition)
    (list 'quote (class-name form))))

(define (show-class name)
  (eval (maknam name '-definition)) )

; TRANSLATE does all the work of DEFINE-CLASS.
; The backquote operator (`) works just like regular quote (') except
; that expressions proceeded by a comma are evaluated.  Also, expressions
; proceeded by ",@" evaluate to lists; the lists are inserted into the
; text without the outermost level of parentheses.

(define (translate form)
  (cond ((null? form) (error "Define-class: empty body"))
	((not (null? (obj-filter form (lambda (x) (not (pair? x))))))
	 (error "Each argument to define-class must be a list"))
	((not (null? (extra-clauses form)))
	 (error "Unrecognized clause in define-class:" (extra-clauses form)))
	(else 
	 `(define ,(class-name form)
	    (let ,(class-var-bindings form)
	      (lambda (class-message)
		(cond
		 ,@(class-variable-methods form)
		 ((eq? class-message 'instantiate)
		  (lambda ,(instantiation-vars form)
		    (let ((self '())
			  ,@(parent-let-list form)
			  ,@(instance-vars-let-list form))
		      (define (dispatch message)
			(cond
			 ,(init-clause form)
			 ,(usual-clause form)
			 ,@(method-clauses form)
			 ,@(local-variable-methods form)
			 ,(else-clause form) ))
		      dispatch )))
		 (else (error "Bad message to class" class-message)) )))))))

(define *legal-clauses*
  '(instance-vars class-vars method default-method parent initialize))

(define (extra-clauses form)
  (obj-filter (cdr form)
	      (lambda (x) (null? (member (car x) *legal-clauses*)))))

(define class-name caar)

(define (class-var-bindings form)
  (let ((classvar-clause (find-a-clause 'class-vars form)))
    (if (null? classvar-clause)
	'()
	(cdr classvar-clause) )))

(define instantiation-vars cdar)

(define (parent-let-list form)
  (let ((parent-clause (find-a-clause 'parent form)))
    (if (null? parent-clause)
	'()
	(map (lambda (parent-and-args)
	       (list (maknam 'my- (car parent-and-args))
		     (cons 'instantiate-parent parent-and-args)))
	     (cdr parent-clause)))))

(define (instance-vars-let-list form)
  (let ((instance-vars-clause (find-a-clause 'instance-vars form)))
    (if (null? instance-vars-clause)
	'()
	(cdr instance-vars-clause))))

(define (init-clause form)
  (define (parent-initialization form)
    (let ((parent-clause (find-a-clause 'parent form)))
      (if (null? parent-clause)
	  '()
	  (map
	   (lambda (parent-and-args)
	     `(ask ,(maknam 'my- (car parent-and-args)) 'initialize self) )
	   (cdr parent-clause) ))))
  (define (my-initialization form)
    (let ((init-clause (find-a-clause 'initialize form)))
      (if (null? init-clause) '()
	  (cdr init-clause))))
  (define (init-body form)
    (append (parent-initialization form)
	    (my-initialization form) ))

  `((eq? message 'initialize)
    (lambda (value-for-self)
      (set! self value-for-self)
      ,@(init-body form) )))

(define (variable-list var-type form)
  (let ((clause (find-a-clause var-type form)))
    (if (null? clause)
	'()
	(map car (cdr clause)) )))

(define (class-variable-methods form)
  (cons `((eq? class-message 'class-name) (lambda () ',(class-name form)))
	(map (lambda (variable)
	       `((eq? class-message ',variable) (lambda () ,variable)))
	     (variable-list 'class-vars form))))

(define (local-variable-methods form)
  (cons `((eq? message 'class-name) (lambda () ',(class-name form)))
	(map (lambda (variable)
	       `((eq? message ',variable) (lambda () ,variable)))
	     (append (cdr (car form))
		     (variable-list 'instance-vars form)
		     (variable-list 'class-vars form)))))

(define (method-clauses form)
  (map
   (lambda (method-defn)
     (let ((this-message (car (cadr method-defn)))
	   (args (cdr (cadr method-defn)))
	   (body (cddr method-defn)))
       `((eq? message ',this-message)
	 (lambda ,args ,@body))))
   (obj-filter (cdr form) (lambda (x) (eq? (car x) 'method))) ))

(define (parent-list form)
  (let ((parent-clause (find-a-clause 'parent form)))
    (if (null? parent-clause)
	'()
	(map (lambda (class) (maknam 'my- class))
	     (map car (cdr parent-clause))))))

(define (usual-clause form)
  (let ((parent-clause (find-a-clause 'parent form)))
    (if (null? parent-clause)
	`((eq? message 'send-usual-to-parent)
	  (error "Can't use USUAL without a parent." ',(class-name form)))
	`((eq? message 'send-usual-to-parent)
	  (lambda (message . args)
	    (let ((method (get-method ',(class-name form)
				      message
				      ,@(parent-list form))))
	      (if (method? method)
		  (apply method args)
		  (error "No USUAL method" message ',(class-name form)) )))))))

(define (else-clause form)
  (let ((parent-clause (find-a-clause 'parent form))
	(default-method (find-a-clause 'default-method form)))
    (cond
     ((and (null? parent-clause) (null? default-method))
      `(else (no-method ',(class-name form))))
     ((null? parent-clause)
      `(else (lambda args ,@(cdr default-method))))
     ((null? default-method)
      `(else (get-method ',(class-name form) message ,@(parent-list form))) )
     (else
      `(else (let ((method (get-method ',(class-name form)
				       message
				       ,@(parent-list form))))
	       (if (method? method)
		   method
		   (lambda args ,@(cdr default-method)) )))))))

(define (find-a-clause clause-name form)
  (let ((clauses (obj-filter (cdr form)
			     (lambda (x) (eq? (car x) clause-name)))))
    (cond ((null? clauses) '())
	  ((null? (cdr clauses)) (car clauses))
	  (else (error "Error in define-class: too many "
		       clause-name "clauses.")) )))

(define (obj-filter l pred)
  (cond ((null? l) '())
	((pred (car l))
	 (cons (car l) (obj-filter (cdr l) pred)))
	(else (obj-filter (cdr l) pred))))

(provide "obj")
