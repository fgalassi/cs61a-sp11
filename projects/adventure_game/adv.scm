;; ADV.SCM
;; This file contains the definitions for the objects in the adventure
;; game and some utility procedures.
(load "tables")

(define-class (basic-object)
  (instance-vars (properties (make-table)))
  (method (put property value)
    (insert! property value properties))
  (method (get property)
    (lookup property properties))
  (default-method (ask self 'get message)))

(define-class (place name)
  (parent (basic-object))
  (instance-vars
   (directions-and-neighbors '())
   (things '())
   (people '())
   (entry-procs '())
   (exit-procs '()))
  (initialize
    (ask self 'put 'place? #t))
  (method (type) 'place)
  (method (neighbors) (map cdr directions-and-neighbors))
  (method (exits) (map car directions-and-neighbors))
  (method (look-in direction)
    (let ((pair (assoc direction directions-and-neighbors)))
      (if (not pair)
	  '()                     ;; nothing in that direction
	  (cdr pair))))           ;; return the place object
  (method (appear new-thing)
    (if (memq new-thing things)
	(error "Thing already in this place" (list name new-thing)))
    (set! things (cons new-thing things))
    'appeared)
  (method (may-enter? person) #t)
  (method (enter new-person)
    (if (memq new-person people)
      (error "Person already in this place" (list name new-person)))
    (set! people (cons new-person people))
    (for-each (lambda (person) (ask person 'notice self)) (cdr people))
    (for-each (lambda (proc) (proc)) entry-procs)
    'appeared)
  (method (gone thing)
    (if (not (memq thing things))
	(error "Disappearing thing not here" (list name thing)))
    (set! things (delete thing things)) 
    'disappeared)
  (method (exit person)
    (for-each (lambda (proc) (proc)) exit-procs)
    (if (not (memq person people))
	(error "Disappearing person not here" (list name person)))
    (set! people (delete person people)) 
    'disappeared)

  (method (new-neighbor direction neighbor)
    (if (assoc direction directions-and-neighbors)
	(error "Direction already assigned a neighbor" (list name direction)))
    (set! directions-and-neighbors
	  (cons (cons direction neighbor) directions-and-neighbors))
    'connected)

  (method (add-entry-procedure proc)
    (set! entry-procs (cons proc entry-procs)))
  (method (add-exit-procedure proc)
    (set! exit-procs (cons proc exit-procs)))
  (method (remove-entry-procedure proc)
    (set! entry-procs (delete proc entry-procs)))
  (method (remove-exit-procedure proc)
    (set! exit-procs (delete proc exit-procs)))
  (method (clear-all-procs)
    (set! exit-procs '())
    (set! entry-procs '())
    'cleared) )

(define-class (locked-place name)
  (parent (place name))
  (instance-vars (unlocked #f))
  (method (may-enter? person) unlocked)
  (method (unlock) (set! unlocked #t)))

(define-class (garage name)
  (parent (place name))
  (instance-vars (ticket-car (make-table)))
  (method (park new-car)
    (if (memq new-car (ask self 'things))
      (let ((new-ticket (instantiate ticket))
            (car-owner (ask new-car 'possessor)))
        (insert! (ask new-ticket 'serial) new-car ticket-car)
        (ask car-owner 'lose new-car)
        (ask self 'gone new-car)
        (ask self 'appear new-ticket)
        (ask car-owner 'take new-ticket))
      (error "Where is your car?")))
  (method (unpark ticket)
    (if (and (object? ticket) (eq? (ask ticket 'name) 'ticket))
      (let* ((serial (ask ticket 'serial))
             (parked-car (lookup serial ticket-car))
             (ticket-owner (ask ticket 'possessor)))
        (if parked-car
          (begin
            (ask ticket-owner 'lose ticket)
            (ask self 'gone ticket)
            (ask self 'appear parked-car)
            (ask ticket-owner 'take parked-car)
            (insert! serial #f ticket-car))
          (error "Car not in this garage!")))
      (error "Not a ticket!"))))

(define-class (ticket)
  (parent (thing 'ticket))
  (class-vars (next-serial 0))
  (instance-vars (serial '()))
  (initialize
    (set! serial next-serial)
    (set! next-serial (+ next-serial 1))))

(define-class (hotspot name password)
  (parent (place name))
  (instance-vars (connected '()))
  (method (connect laptop try-password)
    (if (eq? try-password password)
      (begin (set! connected (cons laptop connected)) 'connected)
      (error "invalid password")))
  (method (gone thing)
    (if (memq thing connected) (set! connected (delete thing connected)))
    (usual 'gone thing))
  (method (surf laptop url)
    (if (memq laptop connected) (system (string-append "lynx " url)) 'not-connected)))

(define-class (laptop name)
  (parent (thing name))
  (method (location)
    (let ((possessor (ask self 'possessor)))
      (if (eq? possessor 'no-one)
        'no-where
        (ask possessor 'place))))
  (method (connect try-password)
    (ask (ask self 'location) 'connect self try-password))
  (method (surf url)
    (ask (ask self 'location) 'surf self url)))

(define-class (person name place)
  (parent (basic-object))
  (instance-vars
   (possessions '())
   (saying ""))
  (initialize
    (ask self 'put 'person? #t)
    (ask self 'put 'strength 50)
    (ask place 'enter self))
  (method (type) 'person)
  (method (look-around)
    (map (lambda (obj) (ask obj 'name))
	 (filter (lambda (thing) (not (eq? thing self)))
		 (append (ask place 'things) (ask place 'people)))))
  (method (take thing)
    (cond ((not (thing? thing)) (error "Not a thing" thing))
	  ((not (memq thing (ask place 'things)))
	   (error "Thing taken not at this place"
		  (list (ask place 'name) thing)))
	  ((memq thing possessions) (error "You already have it!"))
	  (else
	   (announce-take name thing)
	   (set! possessions (cons thing possessions))
	       
	   ;; If somebody already has this object...
	   (for-each
	    (lambda (pers)
	      (if (and (not (eq? pers self)) ; ignore myself
		       (memq thing (ask pers 'possessions)))
		  (begin
		   (ask pers 'lose thing)
		   (have-fit pers))))
	    (ask place 'people))
	       
	   (ask thing 'change-possessor self)
	   'taken)))
  (method (take-all)
    (for-each
      (lambda (avail-thing) (ask self 'take avail-thing))
      (filter
        (lambda (thing) (eq? (ask thing 'possessor) 'no-one))
        (ask place 'things))))

  (method (lose thing)
    (set! possessions (delete thing possessions))
    (ask thing 'change-possessor 'no-one)
    'lost)
  (method (talk) (print saying))
  (method (set-talk string) (set! saying string))
  (method (exits) (ask place 'exits))
  (method (notice person) (ask self 'talk))
  (method (go direction)
    (let ((new-place (ask place 'look-in direction)))
      (cond ((null? new-place) (error "Can't go" direction))
            ((not (ask new-place 'may-enter? self)) (error "Locked place"))
	    (else
	     (ask place 'exit self)
	     (announce-move name place new-place)
	     (for-each
	      (lambda (p)
		(ask place 'gone p)
		(ask new-place 'appear p))
	      possessions)
	     (set! place new-place)
	     (ask new-place 'enter self))))) )

(define-class (thing name)
  (parent (basic-object))
  (instance-vars (possessor 'no-one))
  (initialize
    (ask self 'put 'thing? #t))
  (method (type) 'thing)
  (method (change-possessor new-possessor)
    (set! possessor new-possessor)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementation of thieves for part two
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define *foods* '(pizza potstickers coffee))

(define (edible? thing)
  (member? (ask thing 'name) *foods*))

(define-class (thief name initial-place)
  (parent (person name initial-place))
  (instance-vars
   (behavior 'steal))
  (method (type) 'thief)

  (method (notice person)
    (if (eq? behavior 'run)
	(ask self 'go (pick-random (ask (usual 'place) 'exits)))
	(let ((food-things
	       (filter (lambda (thing)
			 (and (edible? thing)
			      (not (eq? (ask thing 'possessor) self))))
		       (ask (usual 'place) 'things))))
	  (if (not (null? food-things))
	      (begin
	       (ask self 'take (car food-things))
	       (set! behavior 'run)
	       (ask self 'notice person)) )))) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; this next procedure is useful for moving around

(define (move-loop who)
  (newline)
  (print (ask who 'exits))
  (display "?  > ")
  (let ((dir (read)))
    (if (equal? dir 'stop)
	(newline)
	(begin (print (ask who 'go dir))
	       (move-loop who)))))


;; One-way paths connect individual places.

(define (can-go from direction to)
  (ask from 'new-neighbor direction to))


(define (announce-take name thing)
  (newline)
  (display name)
  (display " took ")
  (display (ask thing 'name))
  (newline))

(define (announce-move name old-place new-place)
  (newline)
  (newline)
  (display name)
  (display " moved from ")
  (display (ask old-place 'name))
  (display " to ")
  (display (ask new-place 'name))
  (newline))

(define (have-fit p)
  (newline)
  (display "Yaaah! ")
  (display (ask p 'name))
  (display " is upset!")
  (newline))


(define (pick-random set)
  (nth (random (length set)) set))

(define (delete thing stuff)
  (cond ((null? stuff) '())
	((eq? thing (car stuff)) (cdr stuff))
	(else (cons (car stuff) (delete thing (cdr stuff)))) ))

(define (person? obj)
  (and (procedure? obj) (ask obj 'person?)))

(define (thing? obj)
  (and (procedure? obj) (ask obj 'thing?)))

(define (place? obj)
  (and (procedure? obj) (ask obj 'place?)))

(define (name obj attr)
  (let ((stuff (ask obj attr))
        (give-name (lambda (o) (if (object? o) (ask o 'name) o))))
    (if (list? stuff)
      (map give-name stuff)
      (give-name stuff))))
