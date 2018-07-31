;;;2.20
(define (same-parity a . b)
  (let ((logo (remainder a 2)))
    (define (iter lis)
      (cond ((null? lis) (list))
            ((= logo (remainder (car lis) 2)) 
             (cons (car lis) (iter (cdr lis))))
            (else (iter (cdr lis)))))
    (iter b)))
;;;
;(display 
 (same-parity 1 2 3 4 5 7 9 8 7)
 ;)