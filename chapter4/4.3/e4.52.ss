(define (if-fail? exp)
  (tagged-list? exp 'if-fail))
(define (if-fail-exp1 exp) (cadr exp))
(define (if-fail-exp2 exp) (caddr exp))
(define (analyze-if-fail exp)
  (let ((vproc (analyze (if-fail-exp1 exp))))
  (lambda (env succeed fail)
    (vproc
     env
     succeed
     (lambda ()
       ((analyze (if-fail-exp2 exp)) env succeed fail))))))
;
(define e4.52
  '(define (e4.52)
     (display
      (list
       (if-fail (let ((x (an-element-of '(1 3 5))))
                  (require (even? x))
                  x)
                'all-odd)
       (if-fail (let ((x (an-element-of '(1 3 5 8))))
                  (require (even? x))
                  x)
                'all-odd)))
     ))