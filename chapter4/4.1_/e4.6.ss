;;let ......
(define (make-let variable-pairs body)
  (cons 'let (cons variable-pairs body)))
(define (let? exp) (tagged-list? exp 'let))
(define (let-pairs exp) (cadr exp))
(define (let-body exp) (cddr exp))
(define (let-variables exp) (map car (let-pairs exp)))
(define (let-values exp) (map cadr (let-pairs exp)))

(define (let->combination exp)
  (cons (make-lambda (let-variables exp) (let-body exp))
        (let-values exp)))
;;
;(load ".//4.1.2.ss")
(define (test-let->combination)
  (let->combination '(let ((xi 1) (ha 2)) (* xi ha))))
;;
;(test-let->combination)