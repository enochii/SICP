(load "d:\\sicp\\chapter1\\fixed-point.ss")
;;;1_35
(define (golden-ratio)
  (- (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0) 1))