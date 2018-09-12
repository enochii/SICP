(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")

(define s (cons-stream 1 (add-streams s s)))
;;1 2 4 8 16 32 64 128 ...
(infinite-stream-test s)