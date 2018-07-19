(load "d:\\sicp\\chapter1\\1_37.ss")
;;;for square
(load "d:\\sicp\\aux_\\math.ss")

;;;procedure d
(define (d i)
  (+ 1 (* (- i 1) 2)))

(define (mytan x k)
  ;;;procedure n(i) = x^i 
  (define (n i)
    (if (= 1 i)
        x
        (- (* x x))))
  (cont-frac n d k))
;;;test
;(mytan 0.785 10)
;0.9992039901050428