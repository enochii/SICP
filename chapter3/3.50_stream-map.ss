(load "d:\\sicp\\chapter3\\stream-operation.ss")
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream (apply proc (map stream-car argstreams))
                   (apply stream-map
                          (cons proc
                                (map stream-cdr argstreams))))))
;;
;(display-stream (stream-map * (stream 1 2 3 4) (stream 2 3 4 5)))