;; color-segments-list is an association list of the form
;; ((color seg seg seg ...) (color seg seg seg ...) ... )
(define (color-segments->painter color-segments-list)
  (lambda (frame)
    (for-each
     (lambda (color-segments)
       (let ((color (car color-segments))
	     (segments (cdr color-segments)))
	 (for-each
	  (lambda (segment)
	    (draw-colored-line
	     color
	     ((frame-coord-map frame) (start-segment segment))
	     ((frame-coord-map frame) (end-segment segment))))
	  segments)))
     color-segments-list)))

;; c is the name of the color:
;; 0 black
;; 1 blue
;; 2 green
;; 3 cyan
;; 4 red
;; 5 purple
;; 6 yellow
;; 7 white
(define (draw-colored-line c v1 v2)  
  (setpc (cdr (assoc c
		     '((black . 0)
		       (blue . 1)
		       (green . 2)
		       (cyan . 3)
		       (red . 4)
		       (purple . 5)
		       (yellow . 6)
		       (white . 7)))))
  (draw-line v1 v2)
  (setpc 7))
(define (draw-line v1 v2)
  (penup)
  (setxy (- (* (xcor-vect v1) 200) 100)
	 (- (* (ycor-vect v1) 200) 100))
  (pendown)
  (setxy (- (* (xcor-vect v2) 200) 100)
	 (- (* (ycor-vect v2) 200) 100)))
