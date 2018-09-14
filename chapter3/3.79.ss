(load "d:\\sicp\\chapter3\\3.5.4.ss")

(define (solve-2nd f dt y0 dy0)
  (define dy 'fake-dy)
  (define ddy 'fake-ddy)
  
  (define y (integral (delay dy) y0 dt))
  (set! dy (integral (delay ddy) y0 dt))
  (set! ddy (f dy y))
  y)
;;
(define (f dy y) 
  (add-streams (scale-stream dy -1)
               (scale-stream y 2)))
(stream-ref (solve-2nd f 0.001 1 1) 1000)