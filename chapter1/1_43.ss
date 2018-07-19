;;;compose is a scheme-defined procedure
;;;maybe you also can use the procedure defined by ourselves
(define (repeated f n)
  (define (iter i)
    (if (= i n)
        (lambda (x) (f x))
        (compose f (iter (+ i 1)))))
  (iter 1))

(load "d:\\sicp\\aux_\\math.ss")
;;;test
((repeated square 2) 5)