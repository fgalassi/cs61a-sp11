; (a)
(define (bubble-sort! vec)
  (define (loop vec end)
    (define (bubble! vec start end)
      (define (swap vec src dst)
        (let ((temp (vector-ref vec dst)))
         (vector-set! vec dst (vector-ref vec src))
         (vector-set! vec src temp)))
      (let ((next (+ start 1)))
        (cond ((= start end) vec)
              ((> (vector-ref vec start) (vector-ref vec next)) (swap vec start next)
                 (bubble! vec next end))
              (else (bubble! vec next end)))))
    (if (> end 0)
      (begin (bubble! vec 0 end) (loop vec (- end 1)))))
  (loop vec (- (vector-length vec) 1)))

;(b)
; given n elements first comparison between first and second.
; After bubble, second is guaranteed to be greater than first.
; After another bubble, third is guaranteed to be greater than second and first.
; After bubble starting at i, vec[i+1] is guaranteed to be greater than vec[0..i]
; After bubble at n-1 vec[n] is guaranteed to be greater than vec[0..n-1]
; that is max() of vec.
; Recursively bubbling till n-1, then n-2 ... etc ... builds an ascending
; sequence of greatest elements, which is a sorted sequence.

;(c)
; it does (n - 1) bubbles. Each bubble traverses the vector, so the complexity
; is O(n^2)

