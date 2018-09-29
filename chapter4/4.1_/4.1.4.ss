;;NOTE: u may find that codes here are analogous to .\\4.2_\\leval-driver
;;actually i copy from that to the latter, cause when we touch amazing 
;;lazy-evaluation, the code will change continually, and i want to save codes 
;;here
(load "d:\\sicp\\aux_\\helper.ss")
(load "d:\\sicp\\chapter4\\4.1_\\4.1.1.ss")
;(load "d:\\sicp\\chapter4\\4.1_\\4.1.7.ss")
(load "d:\\sicp\\chapter4\\4.1_\\4.1.2.ss")
(load "d:\\sicp\\chapter4\\4.1_\\4.1.3.ss")
(load "d:\\sicp\\chapter4\\4.1_\\env-representation.ss")
;(load "d:\\sicp\\chapter4\\4.2_\\4.2.2.ss")
;(load "d:\\sicp\\chapter4\\4.2_\\4.2.3.ss");;lazy stream
;(load "d:\\sicp\\chapter4\\4.1_\\less-equal-bigger.ss");;<=>
;;maybe cause we use lazy-evaluation, so we should make <=> to be primitive
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
;;prev definition for e4.29
;(manual-eval '(define (id x) (set! count (+ count 1)) x))
;(manual-eval '(define count 0))
;(manual-eval '(define (square x) (* x x)))
;(manual-eval '(define (for-each proc items)
;                (if (null? items)
;                    'done
;                    (begin (proc (car items))
;                           (for-each proc (cdr items))))))
;(load ".\\e4.30.ss")
;(load "d:\\sicp\\chapter4\\4.2_\\e4.31.ss")
;(e4.31)
(driver-loop)

;(manual-eval '(define (id x) (set! count (+ 1 count)) x))
;(manual-eval '(define count 0))
;(manual-eval '(define w (id (id 10))))
;(manual-eval '(define (g x) (+ x 1)))
;(manual-eval '(define (f g x) (g x)))
;(eval_ '(define (fib x) (cond ((eq? x 0) 0) ((eq? x 1) 1) (else (+ (fib (- x 1)) (fib (- x 2)))))) tgv)
;(eval_ '(map car (list (cons 1 2) (cons 1 2))) tgv)
;(eval_ '(map - (list 1 2 3 4 10)) tgv)
;(eval_ '(map fib (list 1 2 3 4 10)) tgv)
;(eval_ '(define (f x) (define (even? n) (if (= n 0) true (odd? (- n 1)))) (define (odd? n) (if (= n 0) false (even? (- n 1)))) (odd? x)) tgv)
;(eval_ '(f 5) tgv)
;(define (f x) (odd? x) (define (even? n) (if (= n 0) true (odd? (- n 1)))) (define (odd? n) (if (= n 0) false (even? (- n 1)))))
;(f 5)
;(eval_ '(cond ((eq? 0 1) 0) (else 1)) tgv)
;(eval_ '(fib 10) tgv)
;(eval_ '(if (eq? 0 1) 'cuole 'duile) tgv)
;(define (xi x) (let ((a (+ x 1)) (b (+ x 2))) (+ a b) ))(xi 4)
;(eq? (eval_ ''*unassigned* tgv) '*unassigned*);;true
;(driver-loop)
;(define tgv the-global-environment)
;(eval_ '(map car (list (cons 1 2))) tgv)
;(eval_ '(define a 1) tgv)
;;(eval_ '(cons a 1) tgv)
;(eval_ 'sss tgv)
;(eval_ (list 'map 'car (list (cons 1 2) (cons 2 3))) tgv)
;(define xi (list 'map 'car (list (cons 1 2) (cons 2 3))))
;(display tgv)
;(primitive-procedure-names)(primitive-procedure-objects)
;(define (3layers x) (define (2layers x) (define (floor x) x) (floor x)) (2layers x))
;(define (2layers x) (define (floor x) x) (floor x))