(define alp (list
             (make-leaf 'boom 1) (make-leaf 'wah 1) 
             (make-leaf 'a 2) (make-leaf 'get 2) 
             (make-leaf 'job 2) (make-leaf 'sha 3)
             (make-leaf 'yip 9) (make-leaf 'na 16)
              ))
(load "d:\\sicp\\chapter2\\hfm-encode.ss")
(define alp-tree (cadr (hfm alp)))
(define song '(get a job 
                   sha na na na na na na na na 
                   get a job
                   sha na na na na na na na na
                   wah yip yip yip yip yip yip yip yip yip
                   sha boom))
;(display (encode song alp-tree))
(length (encode song alp-tree));;84
;;if we use fixed-length encoding, the length of song will be 108