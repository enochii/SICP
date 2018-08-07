(define (make-product x y)
  ;(list '* x y))
    (cond ((or (=number? x 0) (=number? y 0))
           0)
          ((=number? x 1) y)
          ((=number? y 1) x)
          ((and (number? x) (number? y)) (* x y))
          (else (list '* x y))))

;;product
(define (product? l)
  (and (pair? l) (eq? '* (car l))))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))