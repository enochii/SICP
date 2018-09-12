;(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(load "d:\\sicp\\chapter3\\3.59_integrate-series.ss")
(define (mul-series s1 s2)
  (let ((scale-s2-by-s1car (scale-stream s2 (stream-car s1))))
    (cons-stream (stream-car scale-s2-by-s1car)
                 (add-streams (stream-cdr scale-s2-by-s1car)
                              (mul-series (stream-cdr s1) s2)))))
;;test -> 1 = (sinx}^2 + (cosx)^2
(define (square-streams s) (mul-series s s))
(define zeros (cons-stream 0 zeros))
(define only-one-one (cons-stream 1 zeros))
;(infinite-stream-test 
 (add-streams (square-streams sine-series)
              (square-streams cosine-series));)
;;1 0 0 0 0 0 0.....
;;uh, equal? return #f
;(equal? only-one-one 
        (add-streams (square-streams sine-series)
                     (square-streams cosine-series));)