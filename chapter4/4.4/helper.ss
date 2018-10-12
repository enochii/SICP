;;4.4 helper
(load "d:\\sicp\\chapter3\\stream-operation.ss")
(load "d:\\sicp\\chapter4\\4.4\\table.ss")
(define (tagged-list? exp logo)
  (and (pair? exp)
       (eq? (car exp) logo)
       ))
;stream-append
(define (stream-append s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream
       (stream-car s1)
       (stream-append (stream-cdr s1) s2))))
;
(define (add! exp) (add-rule-or-assertion! (add-assertion-body exp)))
(define (add-all! exps)
  (map (lambda (exp) (add! (list 'assert! exp))) exps))
(load "d:\\sicp\\chapter4\\4.4\\sample-package.ss")