(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
;(load "d:\\sicp\\chapter3\\3.50_stream-map.ss")
(define (mul-streams s1 s2)
  (stream-map * s1 s2))
(infinite-stream-test (mul-streams ints ints))

;;factorial
(define facts
  (cons-stream 1
               (mul-streams (stream-cdr ints)
                            facts)))
(infinite-stream-test facts)