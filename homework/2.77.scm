; magnitude is invoked with z then
; apply generic is invoked with z
; and it dispatches to (get 'magnitude '(complex))
; magnitude is invoked again with (contents z)
; apply generic invoked again with (contents z)
; and it dispatches to (get 'magnitude '(rectangular)
; rectangular package's magnitude is invoked returning the right result
