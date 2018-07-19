;;;1_42
(load "d:\\sicp\\aux_\\math.ss")
(define (mycompose f g)
  (lambda (x)
    (f (g x))))
((mycompose square inc) 6);49
