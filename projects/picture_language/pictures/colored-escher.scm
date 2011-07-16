;; From http://www.frank-buss.de/lisp/functional.html
;;
;; Modified to work with project 2
;;

(load "picture.scm") ;; make sure this works already
(load "colorpic.scm") ;; colored fish!

(define ul-fish
  (color-segments->painter
   (list
    (cons 'yellow
	  (list
	   (make-segment (make-vect 0.25 0.25) (make-vect 0.375 0))
	   (make-segment (make-vect 0 0.1875) (make-vect 0.1875 0.25))
	   (make-segment (make-vect 0.1875 0.25) (make-vect 0 0.5))
	   (make-segment (make-vect 0 0.5) (make-vect 0 0.1875))
	   (make-segment (make-vect 0.25 0.3125) (make-vect 0.4375 0.375))
	   (make-segment (make-vect 0.4375 0.375) (make-vect 0.25 0.625))
	   (make-segment (make-vect 0.25 0.625) (make-vect 0.25 0.3125))
	   (make-segment (make-vect 0.6875 0) (make-vect 0.625 0.25))
	   (make-segment (make-vect 0.625 0.25) (make-vect 0.5 0.5))
	   (make-segment (make-vect 0.5 0.5) (make-vect 0.25 0.8125))
	   (make-segment (make-vect 0.25 0.8125) (make-vect 0 1))))
    (cons 'yellow
	  (list
	   (make-segment (make-vect 0.5 0.5) (make-vect 0.75 0.5625))
	   (make-segment (make-vect 0.75 0.5625) (make-vect 1 0.5))
	   (make-segment (make-vect 0.5 0.75) (make-vect 1 0.625))
	   (make-segment (make-vect 0.5 1) (make-vect 0.75 0.75))
	   (make-segment (make-vect 0.75 0.75) (make-vect 1 0.75))))
    (cons 'blue
	  (list
	   (make-segment (make-vect 0.6875 0) (make-vect 0.875 0.125))
	   (make-segment (make-vect 0.875 0.125) (make-vect 1 0.125))
	   (make-segment (make-vect 0.625 0.25) (make-vect 0.8125 0.3125))
	   (make-segment (make-vect 0.8125 0.3125) (make-vect 1 0.25))
	   (make-segment (make-vect 0.5625 0.375) (make-vect 0.75 0.4375))
	   (make-segment (make-vect 0.75 0.4375) (make-vect 1 0.375))
	   (make-segment (make-vect 0 1) (make-vect 0.375 0.9375))
	   (make-segment (make-vect 0.375 0.9375) (make-vect 0.5 1))
	   (make-segment (make-vect 0.625 1) (make-vect 0.75 0.875))
	   (make-segment (make-vect 0.75 0.875) (make-vect 1 0.8125))
	   (make-segment (make-vect 0.75 1) (make-vect 0.8125 0.9375))
	   (make-segment (make-vect 0.8125 0.9375) (make-vect 1 0.875))
	   (make-segment (make-vect 0.875 1) (make-vect 1 0.9375)))))) )

(define ur-fish
  (color-segments->painter
   (list
    (cons 'yellow
	  (list
	   (make-segment (make-vect 0.5 0) (make-vect 0.625 0.375))
	   (make-segment (make-vect 0.625 0.375) (make-vect 0.625 0.5625))
	   (make-segment (make-vect 0.625 0) (make-vect 0.875 0.6875))
	   (make-segment (make-vect 0.75 0) (make-vect 0.8125 0.25))
	   (make-segment (make-vect 0.8125 0.25) (make-vect 1 0.5))))
    (cons 'blue
	  (list
	   (make-segment (make-vect 0.125 0) (make-vect 0.25 0.3125))
	   (make-segment (make-vect 0.25 0.3125) (make-vect 0.25 0.4375))
	   (make-segment (make-vect 0.25 0) (make-vect 0.375 0.3125))
	   (make-segment (make-vect 0.375 0.3125) (make-vect 0.375 0.4375))
	   (make-segment (make-vect 0.375 0) (make-vect 0.5 0.3125))
	   (make-segment (make-vect 0.5 0.3125) (make-vect 0.5 0.5))
	   (make-segment (make-vect 1 0.5) (make-vect 0.9375 0.625))
	   (make-segment (make-vect 0.9375 0.625) (make-vect 1 1))
	   (make-segment (make-vect 0.125 1) (make-vect 0.1875 0.8125))
	   (make-segment (make-vect 0.25 1) (make-vect 0.3125 0.875))
	   (make-segment (make-vect 0.375 1) (make-vect 0.4375 0.9375))
	   (make-segment (make-vect 0.8125 0) (make-vect 1 0.375))
	   (make-segment (make-vect 0.875 0) (make-vect 1 0.25))
	   (make-segment (make-vect 0.9375 0) (make-vect 1 0.125))))
    (cons 'yellow
	  (list	       	   	   
	   (make-segment (make-vect 1 1) (make-vect 0.75 0.625))
	   (make-segment (make-vect 0.75 0.625) (make-vect 0.375 0.4375))
	   (make-segment (make-vect 0.375 0.4375) (make-vect 0.25 0.4375))
	   (make-segment (make-vect 0.25 0.4375) (make-vect 0 0.5))
	   (make-segment (make-vect 0 0.625) (make-vect 0.4375 0.6875))
	   (make-segment (make-vect 0.5625 0.75) (make-vect 0.625 0.625))
	   (make-segment (make-vect 0.625 0.625) (make-vect 0.75 0.75))
	   (make-segment (make-vect 0.75 0.75) (make-vect 0.5625 0.75))
	   (make-segment (make-vect 0.5 0.9375) (make-vect 0.5625 0.8125))
	   (make-segment (make-vect 0.5625 0.8125) (make-vect 0.6875 0.9375))
	   (make-segment (make-vect 0.6875 0.9375) (make-vect 0.5 0.9375))
	   (make-segment (make-vect 0 0.75) (make-vect 0.1875 0.8125))
	   (make-segment (make-vect 0.1875 0.8125) (make-vect 0.4375 0.9375))
	   (make-segment (make-vect 0.4375 0.9375) (make-vect 0.5 1)))) )) )

(define bl-fish
  (color-segments->painter
   (list
    (cons 'blue
	  (list
	   (make-segment (make-vect 0 0.75) (make-vect 0.0625 0.875))
	   (make-segment (make-vect 0 0.5) (make-vect 0.125 0.75))
	   (make-segment (make-vect 0 0.25) (make-vect 0.3125 0.625))
	   (make-segment (make-vect 0 0) (make-vect 0.5 0.5))
	   (make-segment (make-vect 0.0625 0.0625) (make-vect 0.25 0))
	   (make-segment (make-vect 0.125 0.125) (make-vect 0.5 0))
	   (make-segment (make-vect 0.1875 0.1875) (make-vect 0.5 0.125))
	   (make-segment (make-vect 0.5 0.125) (make-vect 0.75 0))
	   (make-segment (make-vect 0.3125 0.3125) (make-vect 0.75 0.1875))
	   (make-segment (make-vect 0.75 0.1875) (make-vect 1 0))
	   (make-segment (make-vect 0.75 0.75) (make-vect 1 1))
	   (make-segment (make-vect 0.8125 0.8125) (make-vect 1 0.625))
	   (make-segment (make-vect 0.875 0.875) (make-vect 1 0.75))
	   (make-segment (make-vect 0.9375 0.9375) (make-vect 1 0.875))))
    (cons 'yellow
	  (list	   
	   (make-segment (make-vect 0 1) (make-vect 0.125 0.75))
	   (make-segment (make-vect 0.125 0.75) (make-vect 0.5 0.5))
	   (make-segment (make-vect 0.5 0.5) (make-vect 0.875 0.375))
	   (make-segment (make-vect 0.875 0.375) (make-vect 1 0.25))
	   (make-segment (make-vect 0.375 1) (make-vect 0.6875 0.625))
	   (make-segment (make-vect 0.6875 0.625) (make-vect 1 0.375))
	   (make-segment (make-vect 0.6875 1) (make-vect 0.75 0.75))
	   (make-segment (make-vect 0.75 0.75) (make-vect 1 0.5)))) )))

(define br-fish
  (color-segments->painter
   (list
    (cons 'yellow
	  (list
	   (make-segment (make-vect 0 0) (make-vect 0.25 0.125))
	   (make-segment (make-vect 0.25 0.125) (make-vect 0.5 0.125))
	   (make-segment (make-vect 0.5 0.125) (make-vect 1 0))
	   (make-segment (make-vect 0 0.25) (make-vect 0.125 0.0625))
	   (make-segment (make-vect 0 0.375) (make-vect 0.4375 0.25))
	   (make-segment (make-vect 0 0.5) (make-vect 0.5 0.375))))
    (cons 'blue
	  (list
	   (make-segment (make-vect 0 0.625) (make-vect 0.4375 0.5))
	   (make-segment (make-vect 0 0.75) (make-vect 0.4375 0.625))
	   (make-segment (make-vect 0 0.875) (make-vect 0.4375 0.8125))
	   (make-segment (make-vect 0.8125 0.8125) (make-vect 1 0.875))
	   (make-segment (make-vect 0.875 0.6875) (make-vect 1 0.75))
	   (make-segment (make-vect 0.9375 0.5625) (make-vect 1 0.625))))
    (cons 'yellow
	  (list
	   (make-segment (make-vect 0.5 1) (make-vect 0.4375 0.8125))
	   (make-segment (make-vect 0.4375 0.8125) (make-vect 0.4375 0.5))
	   (make-segment (make-vect 0.4375 0.5) (make-vect 0.5 0.375))
	   (make-segment (make-vect 0.5 0.375) (make-vect 0.625 0.25))
	   (make-segment (make-vect 0.625 0.25) (make-vect 1 0))
	   (make-segment (make-vect 0.625 1) (make-vect 0.6875 0.625))
	   (make-segment (make-vect 0.625 0.375) (make-vect 0.75 0.25))
	   (make-segment (make-vect 0.75 0.25) (make-vect 0.75 0.4375))
	   (make-segment (make-vect 0.75 0.4375) (make-vect 0.625 0.375))
	   (make-segment (make-vect 0.8125 0.4375) (make-vect 0.9375 0.3125))
	   (make-segment (make-vect 0.9375 0.3125) (make-vect 0.9375 0.5))
	   (make-segment (make-vect 0.9375 0.5) (make-vect 0.8125 0.4375))
	   (make-segment (make-vect 0.75 1) (make-vect 0.8125 0.8125))
	   (make-segment (make-vect 0.8125 0.8125) (make-vect 0.9375 0.5625))
	   (make-segment (make-vect 0.9375 0.5625) (make-vect 1 0.5))))) ))


(define (quartet ul ur bl br)
  (below (beside bl br)
	 (beside ul ur)))

(define (cycle p)
  (let ((half (beside p (rotate270 p))))
    (below (rotate180 half) half)))

(define fish1 (below (beside bl-fish br-fish)
		     (beside ul-fish ur-fish)))
(define fish2 (cycle (rotate90 ur-fish)))

(define blank (segments->painter '()))
(define side1 (quartet blank blank
		       (rotate90 fish1) fish1))

(define side2 (quartet side1 side1 (rotate90 fish1) fish1))

(define corner1 (quartet blank blank blank fish2))

(define corner2 (quartet corner1 side1 (rotate90 side1) fish2))

(define corner3 (quartet corner2 side2 (rotate90 side2) (rotate90 fish1)))

(define escher-fish (cycle corner3))  

(define (draw-escher-fish)
  (escher-fish (make-frame (make-vect -0.8 -0.8)
			   (make-vect 2.6 0)
			   (make-vect 0 2.6))))



;; Used to transform the segment lists on the site
;; to fit our data abstraction.
;; should also deep-map (lambda (x) (/ x 16))
;; to put the coordinates in the unit square

(define (respect-abstraction seg-list)
  (cons 'list
	(map (lambda (seg)
	       (cons 'make-segment
		     (map (lambda (pt)
			    (cons 'make-vect pt))
			  seg)))
	     seg-list)))

