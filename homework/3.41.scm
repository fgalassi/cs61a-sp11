(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw))
            ((eq? m 'deposit) (protected deposit))
            ((eq? m 'balance)
             ((protected (lambda () balance))))   ;serialized
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
      dispatch))

; This is unnecessary because method balance just reads the value. Even if it is
; interleaved with other operations it can have just 2 results, return the
; balance before the operation and after the operation which are both ok.
