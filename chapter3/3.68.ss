(load "d:\\sicp\\chapter3\\prime-sum-pairs.ss")
(define (pairs368 s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
               t)
   (pairs368 (stream-cdr s) (stream-cdr t))));;this will touch off a infinite loop
(display-stream (pairs368 ints ints))