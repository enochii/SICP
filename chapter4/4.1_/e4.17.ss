;;e4.17
;;transformed program finally will transform let-exp into lambda-exp with 
;;args, and when u calculate it, our ecaluator will call extend-environment
;;proc, which will make an extra frame. and primitive program evaluated will
;;just call define-variable-value!, which add vars in current frame.
;
;;maybe we just do like this :
'(lambda <vars>
   (define u <e1>)
   (define v <e2>)
   <e3>)
;       ||
'(lambda <vars>
   (define u '*unassigned)
   (define v '*unassigned)
   
   (set! u <e1>)
   (set! v <e2>)
   <e3>)
;;
;(load "d:\\sicp\\chapter4\\4.1_\\4.1.2.ss")
;;u may find the code here is analogous to e4.16, yep, i just copy it...
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
    (make-lambda (lambda-parameters exp)
                 (let* ((result (search-define-iter body))
                        (var-val-list (car result))
                        (rest-exps (cdr result)))
                   (append
                    (map 
                     (lambda (pair) (list 'define (car pair) ''*unassigned*))
                     var-val-list)
                    (map 
                     (lambda (pair) (list 'set! (car pair) (cadr pair)))
                     var-val-list)
                    rest-exps)))))
;      > (scan-out-define
;         '(lambda <vars> (define u <e1>) (define v <e2>) <e3>))
;result> (lambda <vars>
;          (define u '*unassigned*)
;          (define v '*unassigned*)
;          (set! u <e1>)
;          (set! v <e2>)
;          <e3>)