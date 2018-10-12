(load "d:\\sicp\\chapter4\\4.4\\helper.ss")
(map (lambda (number)
       (load 
        (string-append
         "d:\\sicp\\chapter4\\4.4\\4.4.4\\4.4.4."
         (number->string number)
         ".ss")))
     '(2 3 4 5 6 7 8))
;input and output format
(define input-prompt ";;; Query input")
(define output-prompt ";;; Query results")
(define (prompt-for-input string)
  (newline)(newline) (display string)(newline))

(define (query-driver-loop)
  (prompt-for-input input-prompt)
  (let ((q (query-syntax-process (read))))
    (cond ((assertion-to-be-added? q)
           (add-rule-or-assertion! (add-assertion-body q))
           (newline)
           (display "Assertion added to data base. ")
           (query-driver-loop))
          (else
           ;(display q)
           (newline)
           (display output-prompt)
           (newline)
           (display-stream
            (stream-map
             (lambda (frame)
               (instantiate q
                 frame
                 (lambda (v f)
                   (contract-question-mark v))))
             (qeval q (singleton-stream '()))))
           (query-driver-loop)))))
;instantiate
(define (instantiate exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
             (if binding
                 (copy (binding-value binding))
                 (unbound-var-handler exp frame))))
          ((pair? exp)
           (cons (copy (car exp)) (copy (cdr exp))))
          (else exp)))
  (copy exp))
;(qeval '(lives-near (? x) (? y)) (singleton-stream '()))
;(add! '(assert! (job ben dalao)))
(add-all! assertions);;see sample-package
(add-all! rules)
(add! '(assert! (married Minnie Mickey)))
(add! '(assert! (rule (married ?x ?y) (married ?y ?x))))
(add! '(assert! (rule (rev-job ?x ?y) (job ?y ?x))))

;(load "d:\\sicp\\chapter4\\4.4\\4.4.4\\e4.74.ss");e4.74
;(load "d:\\sicp\\chapter4\\4.4\\4.4.4\\e4.75.ss");unique
(load "d:\\sicp\\chapter4\\4.4\\4.4.4\\e4.76.ss");nand
;(((? a) (? x)) ((? x) (? z)))
(query-driver-loop)