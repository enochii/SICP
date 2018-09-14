(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
;(load "d:\\sicp\\chapter3\\integral.ss")
(load "d:\\sicp\\chapter3\\3.50_stream-map.ss")
(load "d:\\sicp\\chapter3\\display-stream.ss")

;(display-stream (integral ints 0 0.5))
;;
(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream
     initial-value
     (let ((integrand (force delayed-integrand)))
       (add-streams (scale-stream integrand dt)
                  int))))
  int)
;(define y (integral (delay dy) 1 0.001))
;y
;(define dy (stream-map (lambda (x) x) y))
;dy
;(display-stream y 1000)

(define (solve f y0 dt)
  ;;we need to define a fake dy ahead of time,or the defination
  ;; of y and dy below will touch off an error
  (define dy 'fake-dy)
  (define y (integral (delay dy) y0 dt))
  (set! dy (stream-map f y));;the real dy
  
  y
  )

;(stream-ref (solve (lambda (x) x) 1 0.001) 1000)

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream
     initial-value
     (add-streams (scale-stream (force delayed-integrand) dt)
                  int)))
  (display "see here!")
  int)
;(stream-ref (solve (lambda (x) x) 1 0.001) 1000)