;;;for average
(load "d:\\sicp\\aux_\\math.ss")

(define tolerance 0.00001)
;;;不动点
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? next guess)
          next
          (try next))))
  (try first-guess))
(define (mysqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))