(define (make-exponentiation b e)
  (cond ((= e 0) 1)
        ((= e 1) b)
        (else (list '** b e))))
;;
(define (exponentiation? exp)
  (and (pair? exp) (eq? (car exp) '**)))
(define (base exp)
  (cadr exp))
(define (exponent exp)
  (caddr exp))
;;
(load "d:\\sicp\\chapter2\\deriv-base.ss")
(define (deriv_ exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv_ (addend exp) var)
                   (deriv_ (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv_ (multiplicand exp) var))
          (make-product (multiplicand exp)
                        (deriv_ (multiplier exp) var))))
        ((exponentiation? exp)
         (let ((b (base exp))
               (e (exponent exp)))
           (make-product e
                         (make-product
                          (make-exponentiation b (- e 1))
                          (deriv_ b var)))))
        (else
         (error "unknown expression type -- DERIV" exp))))
;;test
(display (deriv_ (make-product 2 
                               (make-exponentiation 'x 4)) 
                 'x))
;;(* 4 (** x 3))
;(exponentiation? (make-exponentiation 'x 4))
