;;Evaluator data structure
;;
;;conditional
(define (true? x)
  (not (eq? x 'false)))
(define (false? x)
  (eq? x 'false))
;compound-proc
(define (make-procedure parameters body env);;be care of 'env
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))
;primitive
;(define (apply-primitive-procedure proc args)
;  (error "please imp me!"))