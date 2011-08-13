; The last item is inserted into the queue twice!
; No, the last item is shared by the front pointer and the rear pointer so it's
; printed twice
;
; When i delete all items the last one is still there!
; No, the abstraction says that the queue is empty when the front pointer is
; null. The rear pointer can still point to the last item but when next item is
; inserted the rear pointer is updated leaving that old item alone.

(define (print-queue q) (front-ptr q))
