; conventional:
; to add a type, go into each generic operation and add a cond to deal with the new type
; to add an operation, create a new function for the operation dealing with every available type
; BEST IF WE FREQUENTLY ADD NEW OPERATIONS

; message-passing:
; to add a type, create a new function for the type dealing with every available operation
; to add an operation, go into each function representing a type and add a cond to deal with the new operation
; BEST IF WE FREQUENTLY ADD NEW TYPES

; data-directed:
; to add a type, put a line for each operation into the dispatch table
; to add an operation, put a line for each type into the dispatch table
; BEST IF WE HAVE BOTH CASES
