(encode
  '(get a job
    sha na na na na na na na na
    get a job
    sha na na na na na na na na
    wah yip yip yip yip yip yip yip yip yip
    sha boom)
  (generate-huffman-tree
    '((a 2) (boom 1) (get 2) (job 2) (na 16) (sha 3) (yip 9) (wah 1))))

; how many bits are required?
; (1 1 1 1 1 1 1 0
;  0 1 1 1 1 0 1 1
;  1 0 0 0 0 0 0 0
;  0 0 1 1 1 1 1 1
;  1 0 0 1 1 1 1 0
;  1 1 1 0 0 0 0 0
;  0 0 0 0 1 1 0 1
;  0 1 0 1 0 1 0 1
;  0 1 0 1 0 1 0 1
;  0 1 0 1 1 1 0 1
;  1 0 1 1)
;  84 bits

; smallest number of bits with fixed-length
; 8 symbols = 3 bits
; message = 36 symbols * 3 bits = 108 bits
