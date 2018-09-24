;;e4.16-17
;;i think maybe my solutions for this two exercises is something wrong, maybe
;;iwe just need to adjust the search-define-iter, i should not have assumed
;;that definitions is in the front of exp.
;
(load "d:\\sicp\\aux_\\filter.ss")
(load "d:\\sicp\\chapter4\\4.1_\\e4.6.ss")
(load "d:\\sicp\\chapter4\\4.1_\\4.1.2.ss")
(define (not-definition? exp) (not (definition? exp)))
;;e4.16
(define (scan-out-define exp)
  (if (not-definition? (car (lambda-body exp)))
      exp
      (let ((var-val-list
             (map 
              (lambda (expr) 
                (list (definition-variable expr)
                      (definition-value expr)))
              (filter
               definition?
               (lambda-body exp))))
            (rest-exps
             (filter not-definition? (lambda-body exp))))
        (make-lambda
         (lambda-parameters exp)
         (list;;tranform let-exp to a lambda-body
          (make-let (map (lambda (pair) (list (car pair) ''*unassigned))
                         var-val-list)
                    (append
                     (map (lambda (pair) (list 'set! (car pair) (cadr pair)))
                          var-val-list)
                     rest-exps)))))))

;;e4.17
(define (scan-out-define-1 exp)
  (let ((args (lambda-parameters exp))
        (body (lambda-body exp)))
    (make-lambda
     args
     (append (filter definition? body)
             (filter not-definition? body)))))
;
(define expr '(lambda (x) (define a 4) (+ a b) (define b (+ 5 x))))
(display (scan-out-define expr))
;(display (scan-out-define-1 expr))