;;;
(load "d:\\sicp\\aux_\\math.ss")
(load "d:\\sicp\\chapter1\\fixed-point.ss")

(define (average-damp f)
  (lambda (x) 
    (average x (f x))))

(define (mysqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))
(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))