(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams
                (stream-cdr s)
                (partial-sums s))))
;(infinite-stream-test (partial-sums ints))