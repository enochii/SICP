(load "d:\\sicp\\chapter2\\deriv-sum.ss")
;;2.57
(define (make-sum a . b)
  (cons '+ (cons a b)))
;;
(define t (make-sum 'x '(+ x 3) 'y))
(define (augend s)
  (let ((rest (cdr (cdr s))))
    (if (null? (cdr rest))
        (car rest);if rest just have 2 nodes
        (cons '+ rest))))
;;
;(display (augend (augend t)))
;(addend t)
;(sum? t)
