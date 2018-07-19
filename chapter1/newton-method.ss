(load "d:\\sicp\\aux_\\math.ss");for square
(load "d:\\sicp\\chapter1\\fixed-point.ss");for fixed-point

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ dx x)) (g x))
       dx)))
(define dx 0.00001)
;;;求零点
(define (newton-transform g)
  (lambda (x) 
    (- x 
       (/ (g x) ((deriv g) x))
       )))

(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))
;;;sqrt
(define (newton-sqrt x)
  (newton-method (lambda (y) (- x (square y))) 1.0))