(equal? '(this is a list) '(this is a list))
;;2.54
(define (equal?? l1 l2)
  (cond ((and (null? l1) (null? l2))
         #t)
        ((eq? (car l1) (car l2))
         (equal?? (cdr l1) (cdr l2)))
        (else #f)))
;;
(equal?? '(this is a list) '(this is a list))
;;2.55
(car ''abracadabra)
(cdr (quote ('q abracadabra)))
(cdr '(list 'a))
(car (quote (quote a)))
'(a b)
'(1 2)