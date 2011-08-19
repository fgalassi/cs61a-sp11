(load "im-client")

(define (im who message)
  ;;;Send message to who.
  (if (not (list? who)) (set! who (list who)))
  (for-each (lambda (client) 
    (if (not
         (send-request (make-request whoiam client 'send-msg message) port-to-server))
        (close-connection)))
    who))

