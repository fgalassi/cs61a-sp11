(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

; Can we use this method to transfer money in a concurrent environment?
; If Yes, what's the difference between the transfer and exchange problems?
;
; Yes it can be used unlike the exchange problem, because the amount to move is
; a constant, while in the exchange problem it must be calculated so there's
; time to change account before money is transfered
