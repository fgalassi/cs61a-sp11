;; Raymond Williams

;; The shapes:
;; p_trianagle
;; p_triangle_dn
;; p_star
;; p_star2    ;; not as nice as p_star, but splits better
;; p_octo
;; p_octo_full


(define p_triangle
  (segments->painter
   (list (make-segment (make-vect 0.5 1.0) (make-vect 1.0 0.0))
         (make-segment (make-vect 0.5 1.0) (make-vect 0.0 0.0))
         (make-segment (make-vect 0.0 0.0) (make-vect 1.0 0.0)))))
(define p_triangle_dn
  (segments->painter
   (list (make-segment (make-vect 0.5 0.0) (make-vect 0.0 1.0))
         (make-segment (make-vect 0.5 0.0) (make-vect 1.0 1.0))
         (make-segment (make-vect 0.0 1.0) (make-vect 1.0 1.0)))))

(define p_star
  (segments->painter
   (list (make-segment (make-vect 0.5 1.00) (make-vect 0.1 0.00))
         (make-segment (make-vect 0.5 1.00) (make-vect 0.9 0.00))
         (make-segment (make-vect 0.0 0.65) (make-vect 1.0 0.65))
         (make-segment (make-vect 0.0 0.65) (make-vect 0.9 0.00))
         (make-segment (make-vect 0.1 0.00) (make-vect 1.0 0.65)))))


;Star2 is not as nice as star, but it splits better.
(define p_star2
  (segments->painter
   (list (make-segment (make-vect 0.5 1.0) (make-vect 0.0 0.0))
         (make-segment (make-vect 0.5 1.0) (make-vect 1.0 0.0))
         (make-segment (make-vect 0.0 0.7) (make-vect 1.0 0.7))
         (make-segment (make-vect 0.0 0.7) (make-vect 1.0 0.0))
         (make-segment (make-vect 0.0 0.0) (make-vect 1.0 0.7)))))

(define p_octo
  (segments->painter
   (list (make-segment (make-vect 0.00 0.33) (make-vect 0.00 0.66))
         (make-segment (make-vect 0.00 0.66) (make-vect 0.33 1.00))
         (make-segment (make-vect 0.33 1.00) (make-vect 0.66 1.00))
         (make-segment (make-vect 0.66 1.00) (make-vect 1.00 0.66))
         (make-segment (make-vect 1.00 0.66) (make-vect 1.00 0.33))
         (make-segment (make-vect 1.00 0.33) (make-vect 0.66 0.00))
         (make-segment (make-vect 0.66 0.00) (make-vect 0.33 0.00))
         (make-segment (make-vect 0.33 0.00) (make-vect 0.00 0.33)))))

(define p_octo_full
  (segments->painter
   (list (make-segment (make-vect 0.00 0.33) (make-vect 0.00 0.66))
         (make-segment (make-vect 0.00 0.33) (make-vect 0.33 1.00))
         (make-segment (make-vect 0.00 0.33) (make-vect 0.66 1.00))
         (make-segment (make-vect 0.00 0.33) (make-vect 1.00 0.66))
         (make-segment (make-vect 0.00 0.33) (make-vect 1.00 0.33))
         (make-segment (make-vect 0.00 0.33) (make-vect 0.66 0.00))
         (make-segment (make-vect 0.00 0.33) (make-vect 0.33 0.00))
         (make-segment (make-vect 0.00 0.66) (make-vect 0.00 0.33))
         (make-segment (make-vect 0.00 0.66) (make-vect 0.33 1.00))
         (make-segment (make-vect 0.00 0.66) (make-vect 0.66 1.00))
         (make-segment (make-vect 0.00 0.66) (make-vect 1.00 0.66))
         (make-segment (make-vect 0.00 0.66) (make-vect 1.00 0.33))
         (make-segment (make-vect 0.00 0.66) (make-vect 0.66 0.00))
         (make-segment (make-vect 0.00 0.66) (make-vect 0.33 0.00))
         (make-segment (make-vect 0.33 1.00) (make-vect 0.00 0.33))
         (make-segment (make-vect 0.33 1.00) (make-vect 0.00 0.66))
         (make-segment (make-vect 0.33 1.00) (make-vect 0.66 1.00))
         (make-segment (make-vect 0.33 1.00) (make-vect 1.00 0.66))
         (make-segment (make-vect 0.33 1.00) (make-vect 1.00 0.33))
         (make-segment (make-vect 0.33 1.00) (make-vect 0.66 0.00))
         (make-segment (make-vect 0.33 1.00) (make-vect 0.33 0.00))
         (make-segment (make-vect 0.66 1.00) (make-vect 0.00 0.33))
         (make-segment (make-vect 0.66 1.00) (make-vect 0.00 0.66))
         (make-segment (make-vect 0.66 1.00) (make-vect 0.33 1.00))
         (make-segment (make-vect 0.66 1.00) (make-vect 1.00 0.66))
         (make-segment (make-vect 0.66 1.00) (make-vect 1.00 0.33))
         (make-segment (make-vect 0.66 1.00) (make-vect 0.66 0.00))
         (make-segment (make-vect 0.66 1.00) (make-vect 0.33 0.00))
         (make-segment (make-vect 1.00 0.66) (make-vect 0.00 0.33))
         (make-segment (make-vect 1.00 0.66) (make-vect 0.00 0.66))
         (make-segment (make-vect 1.00 0.66) (make-vect 0.33 1.00))
         (make-segment (make-vect 1.00 0.66) (make-vect 0.66 1.00))
         (make-segment (make-vect 1.00 0.66) (make-vect 1.00 0.33))
         (make-segment (make-vect 1.00 0.66) (make-vect 0.66 0.00))
         (make-segment (make-vect 1.00 0.66) (make-vect 0.33 0.00))
         (make-segment (make-vect 1.00 0.33) (make-vect 0.00 0.33))
	 (make-segment (make-vect 1.00 0.33) (make-vect 0.00 0.66))
         (make-segment (make-vect 1.00 0.33) (make-vect 0.33 1.00))
         (make-segment (make-vect 1.00 0.33) (make-vect 0.66 1.00))
         (make-segment (make-vect 1.00 0.33) (make-vect 1.00 0.66))
         (make-segment (make-vect 1.00 0.33) (make-vect 0.66 0.00))
         (make-segment (make-vect 1.00 0.33) (make-vect 0.33 0.00))
         (make-segment (make-vect 0.66 0.00) (make-vect 0.00 0.33))
         (make-segment (make-vect 0.66 0.00) (make-vect 0.00 0.66))
         (make-segment (make-vect 0.66 0.00) (make-vect 0.33 1.00))
         (make-segment (make-vect 0.66 0.00) (make-vect 0.66 1.00))
         (make-segment (make-vect 0.66 0.00) (make-vect 1.00 0.66))
         (make-segment (make-vect 0.66 0.00) (make-vect 1.00 0.33))
         (make-segment (make-vect 0.66 0.00) (make-vect 0.33 0.00))
         (make-segment (make-vect 0.33 0.00) (make-vect 0.00 0.33))
         (make-segment (make-vect 0.33 0.00) (make-vect 0.00 0.66))
         (make-segment (make-vect 0.33 0.00) (make-vect 0.33 1.00))
         (make-segment (make-vect 0.33 0.00) (make-vect 0.66 1.00))
         (make-segment (make-vect 0.33 0.00) (make-vect 1.00 0.66))
         (make-segment (make-vect 0.33 0.00) (make-vect 1.00 0.33))
         (make-segment (make-vect 0.33 0.00) (make-vect 0.66 0.00)))))
