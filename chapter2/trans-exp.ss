;;we just think about * and +
(define (=+? x)
  (and (symbol? x) (eq? x '+)))
(define (=*? x)
  (and (symbol? x) (eq? x '*)))
(define (op? x)
  (or (=+? x) (=*? x)))
(define (variable? x)
  (and (not (op? x)) (symbol? x)))

(define (len=3? l);;when the length of a expression is 3, it's simple enough
  (and (list? l) (null? (cdddr l))))
(define (simple-enough? exp)
  (or (number? exp) (variable? exp) (len=3? exp)))
;;filter twice
(define (filter* exp)
  (cond ((or (=+? exp) (simple-enough? exp))
         exp)
        ((null? exp)
         (error "empty list"))
        ((=*? (cadr exp))
         (let ((prev (list 
                      (filter* (car exp)) '*
                      (filter* (caddr exp))))
               (rest (cdddr exp)))
           (if (null? rest)
               prev
               (filter* (cons prev rest)))))
        (else
         (cons (filter* (car exp));;re-calculate->len ==3
               (list '+
                     (filter* (cddr exp))))
         )))
;;
(define s '(x * y * 7 + 2 * 6))
;(display (filter* s))
;;filter+
(define (filter+ exp)
  (cond ((simple-enough? exp)
         exp)
        ((=+? (cadr exp))
         (let ((prev (list (filter+ (car exp)) '+ (filter+ (caddr exp))))
               (rest (cdddr exp)))
           (if (null? rest)
               prev
               (filter+ (cons prev rest)))))
        (else (error "expression has some error" exp))))
;;
(define (trans exp)
  ;;add brackets in proper position of infix expression
         (filter+ (filter* exp)))
;;
;(display (trans s))
(load "d:\\sicp\\chapter2\\deriv-base.ss")
(define (deriv_ exp var)
  (deriv (trans exp) var))
(display (deriv_ s 'x))