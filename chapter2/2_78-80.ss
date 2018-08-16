;;pretend we have put and get, xixi
(define (put op args proc)
  0)
(define (get op args proc)
  1)
  
;;;;;;;;;;;
;;2.78
(define (attach-tag tag x)
  (cond ((number? x)
         x)
        (else
         (cons tag x))))
(define (contents x)
  (cond ((number? x) x)
        ((pair? x) (cdr x))))
(define (type-tag x)
  (cond ((number? x)
         'scheme-number)
        ((pair? x)
         (car x))
        (else error "Unknown type -- TYPE-TAG")))
;;;;;;;;;;;
;;2.79-equ? & 2.80-=zero?
;;install-scheme-number-package
;;...
;;other codes are the same as calculate-sysytem.ss
(put 'equ? '(scheme-number scheme-number)
     =);;scheme-procedure
(put '=zero? '(scheme-number)
     (lambda (x)
       (= x 0)))
;;...
;;end of scheme-numer-package
;;
;;install-rational-package
;;...
;;i assume that the defination of make-rat uses gcd-procedure
;;so we can just define equ? like :
(define (equ?-rational r1 r2)
  (and (= (number r1) (number r2))
       (= (denom r1) (denom r2))))
;;emmm, but i think this's better
(define (equ?-rational1 r1 r2)
  (= (* (number r1) (denom r2))
     (* (denom r1) (number r2))))
(put 'equ? '(rational 'rational)
     equ?-rational)
(put '=zero? '(rational)
     (lambda (x)
       (= (number x) 0)))
;;end of rational-package
;;
;;install-complex-package
;;
;;we have two formats to represent complex, polar and rectangular,
;;and if we transfrom "polar" to "rectgular", it has deviation.
;;;here i use a procedure to ignore the tolerance
(define (close-enough? x y)
  (< (abs (- x y)) 0.00001))
(define (equ?-complex z1 z2)
  (and (close-enough? (real-part_ z1) (real-part_ z2))
       (close-enough? (imag-part_ z1) (imag-part_ z2))))
(put 'equ? '(complex complex)
     equ?-complex)
(put '=zero '(complex)
     (lambda (x)
       (and (= (real-part_ x) 0)
            (= (imag-part_ x) 0))))
;;end of complex-package
;;end of extension
;;
(define (equ? x y)
  (apply-generic 'equ? x y))
;;here write the apply-generic again -=-
(define (apply-generic op args)
  (let ((type-tags (type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (contents args))
          (error "Unknown OP" (list op args))))))