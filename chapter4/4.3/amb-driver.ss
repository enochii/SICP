;;NOTE: u may find that codes here are analogous to .\\4.2_\\leval-driver
;;actually i copy from that to the latter, cause when we touch amazing 
;;lazy-evaluation, the code will change continually, and i want to save codes 
;;here
;(load "d:\\sicp\\aux_\\helper.ss")
;(load "d:\\sicp\\chapter4\\4.1_\\4.1.1.ss")
(load "d:\\sicp\\chapter4\\4.1_\\4.1.7.ss")
(load "d:\\sicp\\chapter4\\4.1_\\4.1.2.ss")
(load "d:\\sicp\\chapter4\\4.1_\\4.1.3.ss")
(load "d:\\sicp\\chapter4\\4.1_\\env-representation.ss")
;(load "d:\\sicp\\chapter4\\4.1_\\less-equal-bigger.ss");;<=>
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'list list)
        (list 'null? null?)
        (list '* *)
        (list '+ +)
        (list '- -)
        (list '/ /)
        (list '= =);;4.1.7, also for lazy-evaluation
        (list 'display display)
        ;(list 'map map);;for test
        ;;....
        ))
(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))
(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             '())))
    (define-variable! 'true #t initial-env)
    (define-variable! 'false #f initial-env)
    ;(upgrade-env initial-env);;this for 4.2.3.ss
    initial-env))
;;
;;to apply a primitive procedure, we simply apply the implementation procedure 
;;to the arguments, using the underlying Lisp system
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
(define apply-in-underlying-scheme apply);;????
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))
(define (primitive-implementation proc) (cadr proc))
;;
(define the-global-environment (setup-environment))

(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval output:")
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval_ input the-global-environment)));;changed for l-eval
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
(define (prompt-for-input string)
  (newline)(newline) (display string)(newline))
(define (announce-output string)
  (newline)(display string)(newline))
;;use the self-defined user-print to avoid printing the env part of a compound
;;procedure
(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))
;
(define tgv the-global-environment)
(define (manual-eval exp) (eval_ exp tgv));;this is mainly for convenience

(driver-loop)