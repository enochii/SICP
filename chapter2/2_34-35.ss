;;;2.34
(load "d:\\sicp\\chapter2\\list_operation.ss")
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))
;;;test
;(display (horner-eval 2 (list 1 3 0 5 0 1)))
;;;2.35
(define (count-leaves tree)
  (accumulate (lambda (x y)
                (if (pair? x)
                    (+ (count-leaves x) y)
                    (+ 1 y)))
              0
              tree))
(define x (cons (list 1 2) (list 3 4)))
(count-leaves x)