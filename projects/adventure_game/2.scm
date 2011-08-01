; 2A. What kind of thing is the value of variable BRIAN?
; a closure
;
; 2B. List all messages that a PLACE understand.
; name
; directions-and-neighbors
; things
; people
; entry-procs
; exit-procs
; type
; neighbors
; exits
; look-in
; appear
; enter
; gone
; exit
; new-neighbor
; add-entry-procedure
; add-exit-procedure
; remove-entry-procedure
; remove-exit-procedure
; clear-all-procs
;
; 2C. What is returned by the following expressions and WHY?
; 
; > (ask Brian 'place)
; closure
; 
; > (let ((where (ask Brian 'place)))
;        (ask where 'name))
; Peoples-Park
;
; >  (ask Peoples-park 'appear bagel)
; error
;
; 2D.
; >  (define computer (instantiate thing 'Durer))
; Which of the following is correct?  Why?
; 
; (ask 61a-lab 'appear computer) <== RIGHT, it's the object
; 
; or
; 
; (ask 61a-lab 'appear Durer) <== WRONG, variable does not exist
; 
; or 
; 
; (ask 61a-lab 'appear 'Durer) <== WRONG, internal name
; 
; What is returned by (computer 'name)?  Why?
; 'Durer because it's the internal name
;
; 2E.
(define-class (thing name)
  (instance-vars (possessor 'no-one))
  (method (type) 'thing)
  (method (change-possessor new-possessor)
    (set! possessor new-possessor)))

; 2F.
(define (whereis person)
  (ask (ask person 'place) 'name))

(define (owner thing)
  (let ((possessor (ask thing 'possessor)))
    (if (symbol? possessor)
      possessor
      (ask possessor 'name))))
