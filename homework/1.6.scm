(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

(define (pigl w)
  (new-if (vowel? (first w))
    (word w 'ay)
    (pigl (word (butfirst w) (first w)))))

(define (vowel? letter)
  (member? letter '(a e i o u)))

; (pigl 'e)
;
; new-if is not a special form so the else clause is always executed
; (pigl (word "" 'e)
; (pigl 'e)
; ...etc... -> leading to infinite recursion
