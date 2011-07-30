; where is the local state for acc kept?
; it's in the frame created by invoking (make-account 50)
; accessible by the dispatch lambda returned and assigned to acc
;
; How are local states for the two accounts kept distinct?
; when invoking make-account a new environment is created for each account
;
; which parts of the environment structure are shared between acc and acc2?
; just the global environment and the make-account procedure
