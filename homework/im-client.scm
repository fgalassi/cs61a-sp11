;NOTES:
;Read NOTES in server.scm:
;   Notes that apply to both server.scm and this file will be kept in 
;   server.scm.


;All logging messages are followed by the comment LOGGING

(load "im-common.scm")


(define logging #t) ; set to true to see logging

(define socket-to-server #f)  	; Socket to server
(define port-to-server #f)  	; write port to server
(define port-from-server #f)  	; Read port from server
(define clients #f)  		; List of known clients

; Your name (can be changed before im-enroll)
(define whoiam (string->word (getenv "USER"))) 

(define (im-enroll server-address port)
  ;;;Start handshake with server.
  ;
  ;Set! global variables.
  ;Send "hello" message.
  ;Check for "welcome" response.
  ;Set! clients variable.
  ;Send "thanks" command.
  ;Set thunk for socket.
  ;
  (if socket-to-server (error "Already logged in!"))
  (set! socket-to-server (make-client-socket server-address port))
  (set! port-to-server (socket-output socket-to-server))
  (set! port-from-server (socket-input socket-to-server))
  
  (format logging "Sending 'hello' request to server.~%")
  (if (not
       (send-request (make-request whoiam 'server 'hello nil)
		     port-to-server))
      (close-connection)
      (begin
	(format logging "Waiting for 'welcome' from server.~%")
	(let ((req (get-request port-from-server)))
	  (if (not req)
	      (close-connection)
	      (begin
		(format logging "Response received: ~S~%" req)
		(cond ((equal? 'sorry (request-action req))
		       (format #t "Another client using same login!~%")
		       (close-connection))
		      
		      ((equal? 'welcome (request-action req))
		       (format logging "Received 'welcome' message.~%")
		       (format logging "Sending 'thanks'.~%")
		       (if (not
			    (send-request (make-request whoiam 'server 'thanks nil)
					  port-to-server))
			   (close-connection)
			   ;; Finally, can set up the handler
			   (begin
			     (setup-request-handler port-from-server)
			     (format logging "(im-enroll) done.~%~%")) ))
		      
		      (else
		       (format #t "Bad response from server: ~S" req)
		       (close-connection)))) ))))
  'okay)


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
	      (received-msg (request-src req) (request-data req)))
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

(define (received-msg from-whom msg)
  ;;;Handles message received from other clients.
  ;Change to GUI in future.
  (format #t "~%Message from ~A:~%    ~A~%~%" from-whom msg))

(define (im who message)
  ;;;Send message to who.
  (if (not
       (send-request (make-request whoiam who 'send-msg message) port-to-server))
      (close-connection)))

(define (update-client-list client-list)
  ;;;Deal with a new client list.
  (set! clients client-list)
  ;Change to GUI in future.
  (format #t "~%New client-list: ~A~%~%" client-list))

(define (close-connection)
  ;;;Closes connection to the server.
  (format logging "Closing down socket and ports...")
  (if (and port-from-server (not (port-closed? port-from-server)))
      (when-port-readable port-from-server #f))
  (set! port-from-server #f)
  (set! port-to-server #f)
  (if (and socket-to-server (not (socket-down? socket-to-server)))
      (socket-shutdown socket-to-server #f))
  (set! socket-to-server #f)
  (set! clients #f)
  ;Change to GUI in future.
  (format #t "Connection to server closed.~%~%"))

(define (im-exit)
  ;;;Log out client.
  (if (not socket-to-server) (error "Already logged out!"))
  (format logging "Letting server know that I'm logging out.~%")
  (if (not
       ;; server will send goodbye
       (send-request (make-request whoiam 'server 'logout nil) port-to-server))
      (close-connection)))
