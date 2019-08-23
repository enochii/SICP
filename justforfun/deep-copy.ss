(define (copy lis)
  (if (null? lis)
      '()
      (cons (car lis) (copy (cdr lis)))))
;
(define a '(1 2 3))
(define ca (copy a))
(set-car! ca 'xixi)
(display ca)
(newline)
(display a)
;
;use lambda to accumulate the elements
(define (copy-1 lis)
  (define (iter rest recieve)
    (if (null? rest)
        (recieve '())
        (iter (cdr rest)
              (lambda (cdr_)
                (recieve (cons (car rest) cdr_))))))
  (iter lis
        (lambda (cdr_)
          cdr_)))