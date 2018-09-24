;;a) finished it in look-up-variable in env-representation.ss
;;b) just like this ...
;(load "d:\\sicp\\chapter4\\4.1_\\4.1.2.ss")
;(load "d:\\sicp\\chapter4\\4.1_\\e4.6.ss")
;;v1, doesn't support define procedure inside
(define (scan-out-define exp);;type of exp is lambda-expression
  ;;we assume that we put the definition in the front of exp-body
  (let ((body (lambda-body exp)))
    ;;use the procedure defined before to simplify oue job
    ;;description of search-define-iter
    ;;@return : a pair combined var-value list the rest expressions
    (define (search-define-iter rest)
      (if (null? rest)
          (error-scan-out-define;;
           "No expression after definitions(bad syntax) -- SCAN-OUT-DEFINE" exp)
          (let ((first (car rest)))
            (if (definition? first)
                (let ((rest-result (search-define-iter (cdr rest))))
                  (cons 
                   (cons 
                    (list (definition-variable first) (definition-value first))
                    (car rest-result))
                   (cdr rest-result)))
                (cons '() rest)))))
    ;(display body)
    (if (not (definition? (car body))) 
        exp
        (let ((result (search-define-iter body)))
          (let ((var-val-list (car result))
                (rest-exps (cdr result)))
            (make-lambda (lambda-parameters exp)
                         (list
                          (make-let;;evaluating ''unassigned will get 'una...
                           (map (lambda (x) (list x ''*unassigned*)) 
                                (map car var-val-list))
                           (append
                            (map (lambda (pair) (cons 'set! pair)) var-val-list)
                            rest-exps)))))))))
;;test result
;> (define r (scan-out-define '(lambda (x) (define a 1) (define b 2) (+ a b))))
;> (lambda-body r)
;(let ((a *unassigned*) (b *unassigned*)) ((set! a 1) (set! b 2) (+ a b))) 
;;c) i add it in the lambda-part of interpreter, it's not so complex, and it can work with nested-definitions