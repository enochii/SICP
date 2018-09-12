;;3.57 O(n) -> O(2^n)

;;3.58
(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)
   ))
;;if 'load is after definnation of expand, expand will use the first defination
;;of cons-stream in .ss
(load "d:\\sicp\\chapter3\\stream-operation.ss")
;;
(infinite-stream-test 
 (expand 1 7 10)
 )
;;1 4 2 8 5 7 ...(repeated)

(infinite-stream-test 
 (expand 3 8 10)
 )
;;3 7 5 0 0 0 0 ...

(cons-stream 1 sddfflwlfplfpe)

;(define xi (delay (+ (a) 1)))

;(define (a) 1)
;(define (a) 'xixi)

;(force xi)