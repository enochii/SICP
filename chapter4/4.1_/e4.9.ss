;(while <predicate>
;       <do-body>)
;;;;;;;;;;;;;;;;;;;
;;      ||
;;     \\//
;(begin (define (while-iter)
;         <predicate>
;         (begin <do-body> (while-iter)))
;       (while-iter))
(define (while? exp)  (tagged-list? exp 'while))
(define (while-predicate exp) (cadr exp))
(define (while-body exp) (cddr exp))
;;
;(begin (define (list) (display "zhenpi"))
;       (list))
;
(define (while->begin exp)
  (make-begin (list
               (list 'define '(while-iter)
                     (list 'if (while-predicate exp)
                           (make-begin 
                            (append (while-body exp)
                                    (list '(while-iter))))
                           ))
               '(while-iter))))
(define (test-while->begin)
  (define a 5)
  (define expr '(while (> a 0)
                       (set! a (- a 1))
                       (display "-1")
                       (newline)))
  (while->begin expr))
(load ".\\4.1.2.ss")
(test-while->begin)
;;output of test-code
(define a 5)
(begin
  (define (while-iter)
    (if (> a 0) (begin (set! a (- a 1)) (display "-1") (newline) (while-iter))))
  (while-iter))
;;BECARE: if a definition of while-iter outside while-expression, it will be overrode by
;;the inside while-iter. that's to say, if u call while-iter in while-body, u may want to 
;;call the outside version, but actully the version we defined inside begin-exp will be 
;;called. but i can't solve this problem by other ways