(load "d:\\sicp\\aux_\\helper.ss")

(load "d:\\sicp\\chapter4\\4.1_\\4.1.3.ss")
(load "d:\\sicp\\chapter4\\4.3\\4.3.3.ss")
(load "d:\\sicp\\chapter4\\4.1_\\env-representation.ss")
(load "d:\\sicp\\chapter4\\4.1_\\4.1.2.ss");;judge type

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'list list)
        (list 'null? null?)
        (list 'length length)
        (list 'reverse reverse)
        (list '* *)
        (list '+ +)
        (list '- -)
        (list '/ /)
        (list '< <)(list '> >)(list '<= <=)(list '>= >=)
        (list '= =);;4.1.7, also for lazy-evaluation
        (list 'display display)
        (list 'newline newline)
        (list 'not not)
        (list 'equal? equal?)
        (list 'eq? eq?)
        (list 'even? even?)
        (list 'remainder remainder)
        ;(list 'and and)
        ;(list 'or or)
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
;;driver loop
(define input-prompt ";;; Amb-Eval input:")
(define output-prompt ";;; Amb-Eval value:")
;
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

;global env
(define the-global-environment (setup-environment))
(define tgv the-global-environment)
;;previous definition
(define (pre-process expr)
  (ambeval expr
           tgv
           (lambda (value fail2) value)
           (lambda () 'failed)))
;(pre-process require)
(load "d:\\sicp\\chapter4\\4.3\\e4.54.ss");;require
(pre-process an-element-of)
(pre-process an-integer-starting-from)
(pre-process prime-sum-pair)
(pre-process e4.51)
(pre-process e4.52)
(load "d:\\sicp\\chapter4\\4.3\\e4.53.ss")

;;e4.35, an-integer-between
;(load "d:\\sicp\\chapter4\\4.3\\e4.35.ss")
;(load "d:\\sicp\\chapter4\\4.3\\4.3.2.ss")
(load "d:\\sicp\\chapter4\\4.3\\distinct-member-abs-definition.ss")
(load "d:\\sicp\\chapter4\\4.3\\and-or.ss")
;(load "d:\\sicp\\chapter4\\4.3\\e4.42.ss")
(load "d:\\sicp\\chapter4\\4.3\\e4.44.ss")
(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (if (eq? input 'try-again)
          (try-again)
          (begin
            (newline)
            (display ";;; Start a new problem ")
            (ambeval input
                     the-global-environment
                     (lambda (val next-alternative)
                       (announce-output output-prompt)
                       (user-print val)
                       (internal-loop next-alternative))
                     (lambda ()
                       (announce-output
                        ";;; There are no more values of:")
                       (user-print input)
                       (driver-loop)))))))
  (internal-loop
   (lambda ()
     (newline)
     (display ";;; There is no current problem")
     (driver-loop))))
;
(driver-loop)