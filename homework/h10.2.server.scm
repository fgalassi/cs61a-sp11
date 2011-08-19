(load "im-server")

(define (setup-client-request-handler name client-sock)
  ;;;Handle messages from the client.
  ;
  ;Only handles "send-msg" and "logout" messages.
  ;
  
  (define (client-request-handler)
    (let* ((port-from-client (socket-input client-sock))
           (port-to-client (socket-output client-sock))
           (req (get-request port-from-client)))
      (define (send-msg sender recipient message)
        (let ((port-to-dst (find-port-to-client recipient)))
            (if port-to-dst
                (begin
                  (format logging "Delivering message from ~A to ~A.~%"
                    sender
                    recipient)
                  (if (not
                        (send-request (make-request sender
                                                    recipient
                                                    'receive-msg
                                                    message)
                                      port-to-dst))
                    (remove-client recipient)))
                (begin
                  (format logging "User not found: ~A. Letting sender know.~%"
                    recipient)
                  (if (not
                        (send-request (make-request 'server
                                                    name
                                                    'receive-msg
                                                    (format #f "User not found: ~A"
                                                            recipient))
                                      port-to-client))
                    (remove-client name)) ))) )
      (if (not req)
	  (remove-client name)
	  (begin	    
	    (format logging "Received request: ~S~%" req)
	    (cond
	     ((equal? 'send-msg (request-action req)) (send-msg (request-src req) (request-dst req) (request-data req)) )
       ((equal? 'broadcast (request-action req)) (for-each (lambda (client)
                                                             (send-msg (request-src req) client (request-data req)))
                                                           (filter (lambda (client) (not (eq? (request-src req) client)))
                                                                   (get-clients-list))))
	     ((equal? 'logout (request-action req))
	      (remove-client name))
	     
	     (else
	      (format logging "Unrecognized action requested: ~A. Letting sender know.~%" (request-action req))
	      (if (not
		   (send-request (make-request 'server
					       (request-dst req)
					       'receive-msg
					       (format #f "Unrecognized action: ~A"
						       (request-action req)))
				 port-to-client))
		  (remove-client name)) ))))
    ;; if other data ready, handle them now    
    (if (and (not (port-closed? port-from-client))
	     (char-ready? port-from-client))
	(client-request-handler)) ))

  ;; Set up the handler
  (when-port-readable (socket-input client-sock) client-request-handler))

