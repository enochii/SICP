;((op +) ...)
(define (operation-exp? exp)
  (and (pair? exp) (tagged-list? (car exp) 'op)))
(define (operation-exp-op exp)
  (cadr (car exp)))
(define (operation-exp-operands exp)
  (cdr exp))
;
(define (make-operation-exp exp machine labels operations)
  (let ((op
         (look-prim (operation-exp-op exp) operations))
        (aprocs
         (map (lambda (operand)
                (if (label-exp? operand);;for exercise 5.9
                    (error
                     "Operand can not be a label! -- MAKE-OPERATION-EXP"
                     operand)
                    (make-primitive-exp operand machine labels)))
              (operation-exp-operands exp))))
    (lambda ()
      (apply op
             (map (lambda (proc) (proc)) aprocs)))))
;
(define (look-prim op ops)
  (let ((res (assoc op ops)))
    (if res
        (cadr res)
        (error "Unknown operation -- ASSEMBLE" op))))