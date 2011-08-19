; Could #1 have been done with the server doing part of the work?
; Could #2 have been done entirely in the client code?
; Compare the virtues of the two approaches.

; 1)
; Yes, by passing a list of clients as request-dst and then doing the dispatch
; on server.

; 2)
; Yes, by sending a message to all other clients appearing in the clients list.

; By doing work on server:
; - You don't need to send multiple messages to server, just one, then server
; dispatches to clients
; - You don't risk to send to disconnected clients. Due to the possible race
; condition when you send a message to a client and the client disconnects in
; the meantime.

; By doing work on client:
; - You don't need to touch server's code

