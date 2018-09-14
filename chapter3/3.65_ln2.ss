(load "d:\\sicp\\chapter3\\3.5.3.ss")
(load "d:\\sicp\\chapter3\\3.55_partial-sums.ss")
(load "d:\\sicp\\chapter3\\display-stream.ss")
(define (ln-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln-summands (+ n 1)))))
(define ln2-stream
  (partial-sums (ln-summands 1)))
(display-stream ln2-stream)
;;
(define ln2-streams
  (make-tableau euler-transform ln2-stream))
;;
(display-stream (stream-ref ln2-streams 1))
;(display-stream (stream-ref ln2-streams 2))
;(display-stream (stream-ref ln2-streams 3))

(display-stream (accelerated-sequence euler-transform ln2-stream))