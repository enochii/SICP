(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((get (car exp));;if exist
         ((get (car exp)) exp env))
        (else
         (error "Unknown expression type -- EVAL" exp))))
(put 'quoted
     (lambda (exp env) (text-of-quotation exp)))
(put 'assignment
     eval-assignment)
(put 'definition
     eval-definition)
(put 'if
     eval-if)
(put 'lambda
     (lambda (exp env)
       (make-procedure (lambda-parameters exp) (lambda-body exp) env)))
(put 'begin
     (lambda (exp env)
       (eval-sequence (begin-actions exp) env)))
(put 'cond
     (lambda (exp env)
       (eval (cond-if exp) env)))
(put 'application
     (lambda (exp env)
       (apply (eval (operator exp) exp) (list-of-values (operands exp) env))))