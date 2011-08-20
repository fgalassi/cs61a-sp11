; ==== SERIALIZER CODE
(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          val))
      serialized-p)))

(define (make-mutex)
  (let ((cell (list false)))            
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire)))
            ((eq? m 'release) (clear! cell))))
    the-mutex))

(define (clear! cell)
  (set-car! cell false))

; just an emulation
(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))


; ===== SERIALIZED EXCHANGE

(define make-account
  (let ((current-number 0))
    (let ((next-number ((make-serializer) (lambda ()
                                            (set! current-number (+ current-number 1))
                                            current-number))))
      (lambda (balance)
        (define (withdraw amount)
          (if (>= balance amount)
              (begin (set! balance (- balance amount))
                     balance)
              "Insufficient funds"))
        (define (deposit amount)
          (set! balance (+ balance amount))
          balance)
        (let ((balance-serializer (make-serializer))
              (number (next-number)))
          (define (dispatch m)
            (cond ((eq? m 'withdraw) withdraw)
                  ((eq? m 'deposit) deposit)
                  ((eq? m 'number) number)
                  ((eq? m 'balance) balance)
                  ((eq? m 'serializer) balance-serializer)
                  (else (error "Unknown request -- MAKE-ACCOUNT"
                               m))))
          dispatch)))))

(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
  (let ((account1-num (account1 'number))
        (account2-num (account2 'number)))
    (let ((first-account (if (< account1-num account2-num) account1 account2))
          (second-account (if (> account1-num account2-num) account2 account1)))
      (((first-account 'serializer) ((second-account 'serializer) exchange))
       account1
       account2))))

; The deadlock problem is resolved because every exchange tries to lock the same
; sequence of accounts. Only one exchange can have the first account of the
; sequence locked so the other are prevented from locking any other account.

