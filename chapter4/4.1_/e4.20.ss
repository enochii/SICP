;v0
(let ((fact
       (lambda (n)
         (if (= n 1)
             1
             (* n (fact (- n 1)))))))
  ;(fact 10)
  '?)
;v1
(letrec ((fact
          (lambda (n)
            (if (= n 1)
                1
                (* n (fact (- n 1)))))))
  (fact 10))
;v2
(let ((fact '*unassigned*))
  (set! fact (lambda (n)
               (if (= n 1)
                   1
                   (* n (fact (- n 1))))))
  (fact 10))
;;v0 can't work, in both our evaluator and Dr-scheme
;;cause v0 will be expanded as an application combined lambda and arguments,
;;such like this
'((lambda (fact)
    (fact 10))
  (lambda (n)
    (if (= n 1)
        1
        (* n (fact (- n 1))))))
;;this is an application, when we send it to our evaluator, to make a binding 
;;combined with fact and (lambda (n) ...) to extend current env, the initial 
;;value of fact, (lambda (n) ...), whose body will be evaluated in a env 
;;without a binding for fact, which touch off an error, unless u define fact 
;;before, but this is not the fact we actually want.
;;
;;code part
;(load "d:\\sicp\\chapter4\\4.1_\\e4.6.ss")
(define (letrec? exp) (tagged-list? exp 'letrec))
(define (letrec-pairs exp) (cadr exp))
(define (letrec-body exp) (cddr exp))
(define (letrec->let exp)
  (let ((pairs (letrec-pairs exp)))
    (make-let
     (map (lambda (pair) (list (car pair) ''*unassigned*)) pairs)
     (append
      (map (lambda (pair) (cons 'set! pair)) pairs)
      (letrec-body exp)))))