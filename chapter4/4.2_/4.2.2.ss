(define (eval_ exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) 
         (let ((result (lookup-variable-value exp env)));;test>>>
           ;(if (stream? result)
               ;(eval_ result env)
               result));)
        ((quoted? exp)
         (let ((text (text-of-quotation exp)))
           (if (pair? text);;need to change the forms of list
               (eval_ text env)
               text
               )))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (let (
               ;(exp (scan-out-define exp))
               )
           ;(display exp)
           (make-procedure (lambda-parameters exp)
                           (lambda-body exp)
                           env)))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval_ (cond->if exp) env))
        ;((let? exp) (eval_ (let->combination exp) env))
        ;((eq?? exp) (eval-eq? exp env))
        ;((map? exp) (eval-map exp env))
        ;((<=>? exp) (eval-<=> exp env))
        ;((letrec? exp) (eval_ (letrec->let exp) env))
        ((stream? exp) exp)
        ((application? exp)
         ;(display exp);;
         (apply_ (actual-value (operator exp) env)
                 (operands exp)
                 env))
        (else
         (error "Unknown expression type -- EVAL" exp))))
;;actual-value
(define (actual-value exp env)
  (force-it (eval_ exp env)))
;;apply
(define (apply_ proc args env)
  (cond ((primitive-procedure? proc)
         ;(display args)
         ;(display proc)(display '4.22.46)
         (apply-primitive-procedure
          proc
          (list-of-arg-values args env)));;changed
        ((compound-procedure? proc)
         (eval-sequence
          (procedure-body proc)
          (extend-environment
           (procedure-parameters proc)
           (list-of-delayed-args args env)
           (procedure-environment proc))))
        (else
         (error
          "Unknown procedure type -- APPLY" proc))))
;;list of arg values
(define (list-of-arg-values exps env)
  (if (no-operands? exps)
      '()
      (cons (actual-value (first-operand exps) env)
            (list-of-arg-values (rest-operands exps) env))))
;;list of delayed args
(define (list-of-delayed-args exps env)
  (if (no-operands? exps)
      '()
      (cons (delay-it (first-operand exps) env)
            (list-of-delayed-args (rest-operands exps) env))))
;;btw, the two above proc can be simplified by map
;;
;;eval-sequence
(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval_ (first-exp exps) env))
        (else (eval_ (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))
;;eval-if
(define (eval-if exp env)
  (if (true? (actual-value (if-predicate exp) env))
      (eval_ (if-consequent exp) env)
      (eval_ (if-alternative exp) env)))
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
;;thunk
(load "d:\\sicp\\chapter4\\4.2_\\thunk-representation.ss")
;(load "d:\\sicp\\chapter4\\4.2_\\e4.31.ss")
;(load "d:\\sicp\\chapter4\\4.2_\\fool-thunk.ss")