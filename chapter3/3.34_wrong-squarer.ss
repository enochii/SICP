(load "d:\\sicp\\chapter3\\constraint.ss")
;;in case of that u set-value for b, the a won't be set,
;;but actually it can be calculated
(define (squarer a b) (multiplier a a b))
(define a (make-connector))
(define b (make-connector))
(probe 'a a)
(probe 'b b)
(squarer a b)

;(set-value! a 4 'user)
(set-value! b 5 'user)
(forget-value! a 'user)