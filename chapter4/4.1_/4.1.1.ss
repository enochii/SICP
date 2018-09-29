;;list-of-value
(load "d:\\sicp\\chapter4\\4.1_\\4.1.2.ss")
(load "d:\\sicp\\chapter4\\4.1_\\eq？.ss")
(load "d:\\sicp\\chapter4\\4.1_\\e4.14.ss");;naive map
(load "d:\\sicp\\chapter4\\4.1_\\e4.6.ss");;let
;(load "d:\\sicp\\chapter4\\4.1_\\e4.16.ss")
;(load "d:\\sicp\\chapter4\\4.1_\\e4.17.ss")
(load "d:\\sicp\\chapter4\\4.1_\\e4.16-17-liugekeng.ss")
(load "d:\\sicp\\chapter4\\4.1_\\e4.20.ss")
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval_ (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))
;;
;;eval
(define (eval_ exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (let ((exp (scan-out-define exp)))
           ;(display exp)
           (make-procedure (lambda-parameters exp)
                           (lambda-body exp)
                           env)))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval_ (cond->if exp) env))
        ((let? exp) (eval_ (let->combination exp) env))
        ((eq?? exp) (eval-eq? exp env))
        ((map? exp) (eval-map exp env))
        ((<=>? exp) (eval-<=> exp env))
        ((letrec? exp) (eval_ (letrec->let exp) env))
        ((application? exp)
         ;(display exp);;
         (apply_ (eval_ (operator exp) env)
                 (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))
;;
;;apply
(define (apply_ procedure arguments)
  ;(display procedure)(newline)(display arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           arguments
           (procedure-environment procedure))))
        (else
         (error "Unknown procedure type -- APPLY" procedure))))

;;eval-if
(define (eval-if exp env)
  (if (true? (eval_ (if-predicate exp) env))
      (eval_ (if-consequent exp) env)
      (eval_ (if-alternative exp) env)))
;;eval-sequence
(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval_ (first-exp exps) env))
        (else (eval_ (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))
;;eval-assignment
(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval_ (assignment-value exp) env)
                       env))
;;eval-definition
(define (eval-definition exp env)
  ;(display "def")(newline)
  (define-variable! (definition-variable exp)
    (eval_ (definition-value exp) env)
    env))

;;BECARE: the expression evaluated is what we "make", not scheme-expression.

(load "d:\\sicp\\chapter4\\4.1_\\less-equal-bigger.ss")