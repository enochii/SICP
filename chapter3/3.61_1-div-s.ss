(load "d:\\sicp\\chapter3\\3.60_mul-series.ss")
'start--3.61--1/s 
(newline)
(define (negate-stream s) (scale-stream s -1))
(define (sub-streams s1 s2) (add-streams s1 (negate-stream s2)))
(define (1/s s)
  (cons-stream 1 (negate-stream
                  (mul-series (1/s s)
                              (sub-streams s only-one-one));;(cons-stream 1 sR)
                  )))
(define (1/s s)
  (cons-stream 1 (negate-stream
                  (mul-series (1/s s) (stream-cdr s));;sR
                  )))
;;
;(infinite-stream-test (sub-streams ints ones))
;(define 1/ints (1/s ints))
;(infinite-stream-test (mul-series 1/ints ints))