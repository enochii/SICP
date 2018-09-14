(load "d:\\sicp\\chapter3\\3.5.4.ss")
(define (solve-2nd a b dt y0 dy0)
  ;;here the integral is the delay version
  ;;and just like solve, we need to
  (define dy 'fake-dy)
  (define ddy 'fake-ddy)
  ;;
  (define y (integral (delay dy) y0 dt))
  (set! dy (integral (delay ddy) dy0 dt))
  (set! ddy (add-streams (scale-stream y b)
                         (scale-stream dy a)))
  y)
;;
(stream-ref (solve-2nd 2 -1 0.001 1 1) 1000)