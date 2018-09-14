(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                            (sqrt-improve guess x))
                           (sqrt-stream x))))
;;in the above procedure, every call to (sqrt-stream x) will generate a new 
;;stream. 
;;if use the proc without memoization, the two

(define a
  (cons-stream (begin (display "pny") 1)
               a))
(define (b)
  (cons-stream (begin (display "pny") 1)
               (b)))
;(infinite-stream-test a);;'pny once
;(infinite-stream-test (b));;'pny several times