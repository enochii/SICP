(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (multiplicand exp)
                        (deriv (multiplier exp) var))))
        (else
         (error "unknown expression type -- DERIV" exp))))
;;
(define (variable? x) (symbol? x))
;;
(define (same-variable? x y)
  (and (variable? x) (variable? y) (eq? x y)))
;;

;;helper-> =number?
(define (=number? x num)
  (and (number? x) (= x num)))
;;load deriv-part
;(load "d:\\sicp\\chapter2\\2_57_deriv-plsum.ss");;2.57
;(load "d:\\sicp\\chapter2\\deriv-product.ss")
;;
(load "d:\\sicp\\chapter2\\2_58a.ss")
(display (deriv (make-product 'x (make-product 'x 'y)) 'x))
;(newline)
;(display (deriv '(* x y) 'x))
;(display (deriv '(+ x y (+ x 3)) 'x))