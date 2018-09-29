;;actually, the extension can also use in a lambda exp.
;;e4.31
(define (parameter-attribute para)
  (cond ((not (pair? para)) 'normal)
        (else (cadr para))))
(define (parameter-name para)
  (cond ((not (pair? para)) para)
        (else (car para))))
(define (parameter-attributes para-list)
  (map parameter-attribute para-list))
(define (parameter-names para-list)
  (map parameter-name para-list))
;;
(define (apply_ proc args env)
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure
          proc
          (list-of-arg-values args env)))
        ((compound-procedure? proc)
         (eval-sequence
          (procedure-body proc)
          (extend-environment
           (parameter-names (procedure-parameters proc))
           (list-of-delayed-args args 
                                 (parameter-attributes (procedure-parameters proc))
                                 env)
           (procedure-environment proc))))
        (else "Unknown procedure type -- APPLY")))
;;
(define (list-of-delayed-args args attributes env)
  (cond ((null? args)
         '())
        (else (cons (delay-it (car args) (car attributes) env)
                    (list-of-delayed-args (cdr args) (cdr attributes) env)))))
(define (delay-it exp atb env)
  (if (eq? 'normal atb)
      (actual-value exp env)
      (list atb exp env)))
;(define (normal? obj) (tagged-list? obj 'normal))
(define (lazy? obj) (tagged-list? obj 'lazy))
;;lazy-mem
(define (lazy-mem? obj) (tagged-list? obj 'lazy-mem))
(define (evaluated? obj) (tagged-list? obj 'evaluated))
;;
(define (obj-value obj) (cadr obj))
(define (obj-exp obj) (cadr obj))
(define (obj-env obj) (caddr obj))
(define (force-it obj)
  (cond ((lazy? obj) (actual-value (obj-exp obj) (obj-env obj)))
        ((lazy-mem? obj)
         (let ((value (actual-value (obj-exp obj) (obj-env obj))))
           (set-car! obj 'evaluated)
           (set-cdr! obj (list value))
           value))
        ((evaluated? obj) (obj-value obj))
        (else obj)))
;;test code, just load this file before driver-loop in 4.1.4.ss to run it
;;for definition of manual-eval here, u can see line 72 in 4.1.4.ss
(define (e4.31)
  (manual-eval '(define (square x) (* x x)))
  (manual-eval '(define (square-lazy (x lazy)) (* x x)))
  (manual-eval '(define (square-lazy-mem (x lazy-mem)) (* x x)))
  ;;show the difference of lazy-mem and normal version
  (manual-eval '(define (self x) (display "self") x))
  (manual-eval '(define (self-lazy-mem (x lazy-mem)) (display "self-lazy-mem") x))
  )
;;test all
;;; M-Eval input:
;(square (begin (display "xixi") 10))
;xixi
;;; M-Eval output:
;100

;;; M-Eval input:
;(square-lazy (begin (display "xixi") 10))
;xixixixi
;;; M-Eval output:
;100

;;; M-Eval input:
;(square-lazy-mem (begin (display "xixi") 10))
;xixi
;;; M-Eval output:
;100
;;show difference between lazy-mem and normal version.
;;; M-Eval input:
;(define self1 (self (self 10)))
;selfself  ;;output
;;; M-Eval output:
#<void>

;;; M-Eval input:
;(define self2 (self-lazy-mem (self-lazy-mem 10)))
;self-lazy-mem  ;;output
;;; M-Eval output:
#<void>

;;; M-Eval input:
;self2
;self-lazy-mem ;;output
;;; M-Eval output:
10
