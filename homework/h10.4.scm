; Implemented everything in client because it's easier and shorter.
; Must explicitly deal with the problem of 2 clients blocking each others. If one sends
; a message the other responds with "message refused", which is again refused,
; etc.. going into an infinite loop.


(define blocked-clients '())

(load "im-client")

(define (setup-request-handler port-from-server)  
  ;;;Handle messages from the server.
  ;
  ;Only handles "receive-msg", "client-list", and "goodbye".
  ;
  (define (request-handler)
    (let ((req (get-request port-from-server)))
      (if (not req)
	  (close-connection)
	  (begin
	    (format logging "Received request: ~S~%" req)
	    (cond
	     ((equal? 'receive-msg (request-action req))
        (if (blocked? (request-src req))
          (blocked-msg (request-src req) (request-data req))
          (received-msg (request-src req) (request-data req))))
	     ((equal? 'client-list (request-action req))
	      (update-client-list (request-data req)))
	     ((equal? 'goodbye (request-action req))
	      (close-connection))
	     (else
	      (format #t "Unknown action requested: ~A~%" (request-action req))
	      (close-connection)))) ))
    ;; if there is more data to handle.
    (if (and (not (port-closed? port-from-server))
	     (char-ready? port-from-server))
	(request-handler)))
  ;; Now set up handler
  (when-port-readable port-from-server request-handler))

(define (blocked? client)
  (member client blocked-clients))

(define (blocked-msg sender msg)
  (if (refused-message? msg)
      (received-msg sender msg))
      (im sender "Message refused!"))

(define (refused-message? msg)
  (equal? msg "Message refused!"))

(define (im-block client)
  (if (blocked? client)
    (error "Already blocked!")
    (begin
      (set! blocked-clients (cons client blocked-clients))
      'blocked)))

(define (im-unblock client)
  (if (blocked? client)
    (begin
      (set! blocked-clients (delete client blocked-clients))
      'unblocked)
    (error "Not blocked!")))
