(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
;3.59
;;a)
(define (helper s1 s2)
  (cons-stream (/ (stream-car s1) (stream-car s2))
               (helper (stream-cdr s1) (stream-cdr s2))))
(define (integrate-series s)
  (helper s ints))
;;
;(infinite-stream-test (integrate-series ones))

;;b)
(define exp-series
  (cons-stream 1
               (integrate-series exp-series)))
;(infinite-stream-test exp-series)
;;
(define cosine-series
  (cons-stream 1 
               (integrate-series (scale-stream sine-series -1))))
(define sine-series
  (cons-stream 0
               (integrate-series cosine-series)))
;(infinite-stream-test cosine-series)
;(infinite-stream-test sine-series)