(load "d:\\sicp\\chapter3\\constraint.ss")
(define (celsius-fahrenheit-converter c f)
  (let ((u (make-connector))
        (v (make-connector))
        (w (make-connector))
        (x (make-connector))
        (y (make-connector)))
    (multiplier c w u)
    (multiplier v x u)
    ;(adder v y f)
    (constant 9 w)
    (constant 5 x)
    (constant 32 y)
    (adder v y f);;just for play
    ;'ok
    ))
;;
(define c (make-connector))
(define f (make-connector))
(define f-setter (celsius-fahrenheit-converter c f))

(define pc (probe "Celsius temp" c))
(probe "Fahrenheit temp" f)

(set-value! c 25 'user);;will not inform c
(forget-value! c 'user)
(set-value! c 5 'user)
(has-value? f)
(forget-value! f f-setter)