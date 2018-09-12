(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(define (partial-sums s)
  (cons-stream 1 (add-streams
                  (stream-cdr ints)
                  (partial-sums s))))
(infinite-stream-test (partial-sums ints))