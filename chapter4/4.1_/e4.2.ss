;;4.2
;a)
;;i guess it may touch a "Unknown expression type" error
;b)
;;we may just need to redefine the 'application?
(define (application? exp)
  (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
;;the same as book code
;(define (no-operands? ops) (null? ops))
;(define (first-operand ops) (car ops))
;(define (rest-operands ops) (cdr ops))