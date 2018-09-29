;;->4.1.2
;;judge the expression type
;(define 'true #t)(define 'false #f);;;;;;;;;;to do
;;BECARE: if u define a quoted exp like the above example, then when u use
;;a quoted exp again, it will be evaluated! i guess... i struggled with it 
;;a long time...
;(load "d:\\sicp\\chapter4\\4.1_\\e4.6.ss")
(define (self-evaluating? exp)
  (cond ((number? exp) #t)
        ((string? exp) #t)
        (else #f)))

(define (variable? exp) (symbol? exp))
;;(quote <text-of-quotation>)
(define (quoted? exp)
  (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))
;;;;;;tagged-list?
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      #f))

;;set!
(define (assignment? exp);;done
  (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))
;;define
(define (definition? exp);;done
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp);;parameter(s)
                   (cddr exp))));;body

;;lambda
(define (lambda? exp) (tagged-list? exp 'lambda));;done
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

;;if
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

(define (if? exp) (tagged-list? exp 'if));done
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

;;begin
(define (begin? exp) (tagged-list? exp 'begin));done
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

;;application
(define (application? exp) (pair? exp));done
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

;;cond
(define (cond? exp) (tagged-list? exp 'cond));done
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause) 
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first);;end
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))