(define (cons_ x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1 -- CONS" m))))
  dispatch)

(define (car_ z) (z 0))
(define (cdr_ z) (z 1))
;;;cons of the above version return a procedure dispatch,
;;;which can apply to 0 or 1




(define (cons__ x y)
  (lambda (m) (m x y)))

(define (car__ z)
  (z (lambda (p q) p)));;;apply z to lambda which return the value of x
(define (cdr__ z)
  (z (lambda (p q) q)))

;;;test
(define a (cons__ 2 6))
(define b (cons__ 1 4))
(display (car__ a))
(newline)
(display (cdr__ b))