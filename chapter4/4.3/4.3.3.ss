(load "d:\\sicp\\chapter4\\4.3\\4.3.1.ss")
(load "d:\\sicp\\chapter4\\4.1_\\e4.6.ss")

(load "d:\\sicp\\chapter4\\4.3\\e4.51.ss");;permanent-set!
(load "d:\\sicp\\chapter4\\4.3\\e4.52.ss");;if-fail

(define (analyze exp)
  ;(display "analyze ")
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp)
         (analyze-quoted exp))
        ((variable? exp)
         (analyze-variable exp))
        ((assignment? exp)
         (analyze-assignment exp))
        ((definition? exp)
         (analyze-definition exp))
        ((if? exp)
         (analyze-if exp))
        ((lambda? exp)
         (analyze-lambda exp))
        ((begin? exp)
         (analyze-sequence (begin-actions exp)))
        ((cond? exp)
         (analyze-if (cond->if exp)))
        ((amb? exp) (analyze-amb exp))
        ((let? exp)
         (analyze-application (let->combination exp)))
        ((permanent-assignment? exp)
         (analyze-permanent-assignment exp))
        ((if-fail? exp)
         (analyze-if-fail exp))
        ((require? exp);;4.54
         (analyze-require exp))
        ((application? exp)
         (analyze-application exp))
        (else
         (error "Unknown expression type - ANALYZE" exp))))
;4.3.3
(define (amb? exp) (tagged-list? exp 'amb))
(define (amb-choices exp) (cdr exp))
;
(define (ambeval exp env succeed fail)
  ((analyze exp) env succeed fail))
;;simple exps
(define (analyze-self-evaluating exp)
  (lambda (env succeed fail)
    (succeed exp fail)))
;
(define (analyze-quoted exp)
  (let ((qeval (text-of-quotation exp)))
    (lambda (env succeed fail)
      (succeed qeval fail))))
;
(define (analyze-variable exp)
  (lambda (env succeed fail)
    (succeed (lookup-variable-value exp env)
             fail)))
;
(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env succeed fail)
      (succeed (make-procedure vars bproc env)
               fail))))
;;conditional and sequences
(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env succeed fail)
      (pproc env
             ;;success continuation for evaluating the predicate
             ;;to obtain pred-value
             (lambda (pred-value fail2)
               (if (true? pred-value)
                   (cproc env succeed fail2)
                   (aproc env succeed fail2)))
             ;;failure continuation for evaluating the predicate
             fail))))
;;my version of al-seq, i find that it's similar to exercise4.23...
(define (analyze-sequence exps)
  (define (loop procs)
    (if (null? (cdr procs))
        proc
        (lambda (env succeed fail)
          ((car proc)
           env
           (lambda (value fail2)
             ((loop (cdr procs)) env succeed fail2))
           fail))))
          
  (let ((procs (map analyze exps)))
    (loop procs)))
;;book version
(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env succeed fail)
      (proc1
       env
       (lambda (proc1-value fail2) 
         (proc2 env succeed fail2))
       fail)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE-SEQUENCE")
        (loop (car procs) (cdr procs)))))
;;definition and assignment
(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env succeed fail)
      (vproc
       env
       (lambda (value fail2)
         (define-variable! var value env)
         (succeed 'ok fail2))
       fail))))
;
(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc
       env
       (lambda (value fail2)
         (let ((old-value (lookup-variable-value var env)))
           (set-variable-value! var value env)
           (succeed 'ok
                    (lambda ()
                      (set-variable-value! var old-value env)
                      (fail2)))))
       fail))))
;;procedure applications
(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env succeed fail)
      (fproc
       env
       (lambda (proc fail2)
         (get-args aprocs
                   env
                   (lambda (args fail3)
                     (execute-application
                      proc args succeed fail3))
                   fail2))
       fail))))
;
(define (get-args aprocs env succeed fail)
  (if (null? aprocs)
      (succeed '() fail)
      ((car aprocs)
       env
       (lambda (arg fail2)
         (get-args (cdr aprocs)
                   env
                   (lambda (args fail3)
                     (succeed (cons arg args) fail3))
                   fail2))
       fail)))
;
(define (execute-application proc args succeed fail)
  (cond ((primitive-procedure? proc)
         (succeed (apply-primitive-procedure proc args)
                  fail))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment (procedure-parameters proc)
                              args
                              (procedure-environment proc))
          succeed
          fail))
        (else
         (error
          "Unknown procedure type - EXECUTE-APPLICATION"
          proc))))
;amb
(define (analyze-amb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((car choices) env
                           (lambda (retval fail2)
                             (succeed retval fail2))
                           (lambda ()
                             (try-next (cdr choices))))))
      (try-next cprocs))))