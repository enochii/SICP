;;subexpressions
(define (make-primitive-exp exp machine labels)
  (cond ((constant-exp? exp)
         (let ((val (constant-exp-value exp)))
           (lambda ()
             val))
         )
        ((label-exp? exp)
         (let ((insts
                (lookup-label labels (label-exp-label exp))))
           (lambda ()
             insts))
         )
        ((register-exp? exp)
         (let ((reg
                (get-register machine (register-exp-reg exp))))
           (lambda ()
             (get-contents reg)))
         )
        (else
         (error "Unknown expression type -- ASSEMBLE"))))
;;
;;form of exp is like (constant 1), etc
(define (constant-exp? exp)
  (tagged-list? exp 'const))
(define (constant-exp-value exp)
  (cadr exp))
;
(define (label-exp? exp)
  (tagged-list? exp 'label))
(define (label-exp-label exp)
  (cadr exp))
;
(define (register-exp? exp)
  (tagged-list? exp 'reg))
(define (register-exp-reg exp)
  (cadr exp))