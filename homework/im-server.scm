;DEAL WITH:
;   EMPTY

;CLEANUP:
;   EMPTY

;POSSIBLE MESSAGES
;=================
;hello -- Used to initialize three-way handshake; client->server.
;welcome -- Lets client know server got "hello"; server->client.
;thanks -- Tells server that client is done logging in; client->server.
;goodbye -- Tells client that its connection to the server is gone; server->client.
;send-msg -- Informs server to send this message to another client; client->server.
;receive-msg -- Message to be received by client; server->client.
;logout -- Informs the server that the client is logging off; client->server.
;client-list -- List of clients logged into the server; server->client.


(load "im-common.scm")

(define logging #t)

;clients variable stores all known clients.
;It's a table of entries in the format ("client name" . client-socket)
(define clients-table (list '*table*))

;Data abstraction for above:
(define key car)
(define value cdr)

;server variable stores the server socket
(define server-socket #f)


(define (add-client-to-table name sock)
  ;;;Add sock to the clients list bound to name
  ;
  ;Broadcasting the new client list is left up to other places in the code.
  ;This is done so as to function as the opposite to (remove-client-from-table).
  ;
  (if (not (assoc name (cdr clients-table)))
      (begin (set-cdr! clients-table (cons (cons name sock) (cdr clients-table))) #t)
      #f))


(define (remove-client-from-table name)
  ;;;Remove name from the clients list
  ;
  ;Broadcasting the new client list is left up to other places in the code.
  ;This is because if the server is shutting down the traffic created by 
  ;sending a new client list after every remove client could be a issue.
  ;
  (define (helper who table)
    ;Remove key-value pair from table, return its value.
    (cond ((null? (cdr table)) #f)
	  ((equal? who (key (cadr table)))
	   (let ((result (value (cadr table))))
	     (set-cdr! table (cddr table))
	     result))
	  (else (helper who (cdr table)))))
  (let ((to-close-socket (helper name clients-table)))
    (if (not (socket-down? to-close-socket))
	(begin 
	  (if (socket-input to-close-socket)
	      (when-port-readable (socket-input to-close-socket) #f))
	  (socket-shutdown to-close-socket #f))))  )


(define (find-client-socket name)
  ;;;Return the socket bound to name; if the name does not exist, return #f
  (let ((result (assoc name (cdr clients-table))))
    (if result
	(value result)
	#f)))


(define (get-clients-list)
  ;;;Return a list of known client names.
  (map key (cdr clients-table)))


(define (im-server-start)
  ;;;Start the server.
  ;
  ;Set! server-socket variable
  ;Set thunk for handling handshake with new client
  ;
  (format logging "~%Server starting...~%")
  (set! server-socket (make-server-socket))
  (format #t "Server IP address: ~A, server port: ~A~%" 
	  (get-ip-address-as-string)
	  (socket-port-number server-socket))
  (when-socket-ready server-socket
		     (lambda () 
		       (begin
			 (format logging "New client connecting.~%")
			 (handshake (socket-dup server-socket)))))
  (format logging "(im-server-start) done.~%~%")
  'okay)


(define (im-server-close)
  ;;;Close  the server by no longer accepting connections,
  ;
  ;Remove thunk on server.
  ;Broadcast "goodbye" message.
  ;Close all client sockets.
  ;Close server socket.
  ;
  (format #t "Server shutting down...~%")
  (server-broadcast 'receive-msg "Server shutting down...")
  (server-broadcast 'goodbye nil)
  (for-each remove-client-from-table (get-clients-list))
  (if (and server-socket (not (socket-down? server-socket)))
      (begin
       (when-socket-ready server-socket #f)
       (socket-shutdown server-socket #f)))
  (set! server-socket #f)
  (set! clients-table (list '*table*))
  (display (format #f "(im-server-close) done.~%~%")))


(define (handshake sock)
  ;;;Handle the three-way handshake with a client.
  ;
  ;Handshaking should go as follows:
  ;client->server:
  ;   request from CLIENT to server with request "hello" and data nil
  ;server->client:
  ;   request from server to CLIENT with request "welcome" and data nil
  ;client->server:
  ;   request from CLIENT to server with request "thanks" and data nil
  ;

  ;;Accept the socket connection
  (socket-accept-connection sock)
  (format logging "Connection accepted for ~A...~%" sock)
  (let* ((port-from-client (socket-input sock))
	 (port-to-client (socket-output sock))
	 (req (get-request port-from-client)))
    (if (not req)
	(socket-shutdown sock #f)
	(begin
	  (format logging "Request received: ~S~%" req)
	 
	  ;; Check message is "hello".
	 
	  (cond ((not (equal? 'hello (request-action req)))
		 (format #t "Bad request from client: ~S"
			 req)
		 (socket-shutdown sock #f))	       
		((member (request-src req) (get-clients-list))
		 ;; name already exists, send "sorry" to client
		 (format logging "Sending 'sorry' to client~%")
		 (send-request (make-request 'server
					     (request-src req)
					     'sorry
					     nil)
			       port-to-client)
		 (format #t "Name ~A already exists."
			 (request-src req))
		 (socket-shutdown sock #f))	       
		(else
		 ;;Send "welcome" message back.
		 (format logging "Sending welcome message.~%")
		 (if (not
		      (send-request (make-request 'server
						  (request-src req)
						  'welcome
						  nil)
				    port-to-client))
		     (socket-shutdown sock #f)		     
		     (begin
		      		 
		       ;; Check response is "thanks"
		       (set! req (get-request port-from-client))
		       (if (not req)
			   (socket-shutdown sock #f)
			   (begin			     	   
			     (format logging "Response received: ~S~%" req)
			     (if (not (equal? 'thanks (request-action req)))
				 (begin (format #t "Bad response from client: ~S" req)
					(socket-shutdown sock #f))
				 (begin
				   ;; Finally, we can register the client
				   (format logging "~A has logged on.~%"
					   (request-src req))
				   (register-client (request-src req)
						    sock)
				   (format logging "Finished handshake~%") )) ) ))))) ))) 
  'okay)


;; Assumes name is not already in client list
(define (register-client name sock)
  ;;;Store socket to client and start handling of the client socket.
  (format logging "~A (~A) is being registered...~%" name sock)
  (if (add-client-to-table name sock)
      (begin
	(format logging "clients: ~A.~%" clients-table)
	(setup-client-request-handler name sock)
	(server-broadcast 'client-list (get-clients-list))
	(format logging "~A is now registered.~%~%" name))
      (error "register-client: client already in table!!")))


(define (setup-client-request-handler name client-sock)
  ;;;Handle messages from the client.
  ;
  ;Only handles "send-msg" and "logout" messages.
  ;
  
  (define (client-request-handler)
    (let* ((port-from-client (socket-input client-sock))
	   (port-to-client (socket-output client-sock))
	   (req (get-request port-from-client)))
      (if (not req)
	  (remove-client name)
	  (begin	    
	    (format logging "Received request: ~S~%" req)
	    (cond
	     ((equal? 'send-msg (request-action req))
	      (let ((port-to-dst (find-port-to-client (request-dst req))))
		(if port-to-dst		   
		    (begin  
		      (format logging "Delivering message from ~A to ~A.~%"
			      (request-src req)
			      (request-dst req))
		      (if (not
			   (send-request (make-request (request-src req) 
						       (request-dst req)
						       'receive-msg
						       (request-data req))
					 port-to-dst))
			  (remove-client (request-dst req))))
		    (begin
		      (format logging "User not found: ~A. Letting sender know.~%"
			      (request-dst req))
		      (if (not
			   (send-request (make-request 'server
						       name
						       'receive-msg
						       (format #f "User not found: ~A"
							       (request-dst req)))
					 port-to-client))
			  (remove-client name)) ))) )
	     
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


(define (find-port-to-client name)
  (let ((sock (find-client-socket name)))
    (if sock (socket-output sock)
	#f)))

(define (remove-client who)
  ;;;Remove client from living clients and send out a new  list of clients.
  (format logging "Removing ~A as a client.~%" who)
  ;;; should send goodbye if port is available
  (format logging "Sending goodbye to ~A~%" who)
  (send-request (make-request 'server
			      who
			      'goodbye
			      nil)
		(find-port-to-client who))
  (remove-client-from-table who)
  (server-broadcast 'client-list (get-clients-list))
  (format logging "~A removed as a client.~%~%" who))


(define (server-broadcast cmd data)
  ;;;Send COMMAND to all clients containing DATA.
  (format logging "Broadcasting the command ~A with data ~S to all clients.~%"
		   cmd data)
  (for-each (lambda (name)
	      (send-request (make-request 'server name cmd data)
			    (find-port-to-client name)))
	    (get-clients-list))
  (format logging "Broadcast done.~%~%"))


;; portable and slightly slow, relies on www-inst.cs.berkeley.edu being up
;;   which is quite reasonable for labs.
(define (get-ip-address-as-string)
  (let* ((s (make-client-socket "www-inst.cs.berkeley.edu" 80))
         (a (socket-local-address s)))
    (socket-shutdown s)
    a))
