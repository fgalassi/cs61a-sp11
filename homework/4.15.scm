; we invoke (try try)
; if (halts? try try) returns true
; then (try try) runs forever which is impossible because
; (halts? try try) told us it would halt.
; if (halts? try try) returns true
; then (try try) halts which is impossible because
; (halts? try try) told us it would run forever.
