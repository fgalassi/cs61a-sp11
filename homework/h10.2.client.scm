(load "im-client")

(define (im-broadcast message)
  ;;;Send message to who.
  (if (not
       (send-request (make-request whoiam 'server 'broadcast message) port-to-server))
      (close-connection)))

