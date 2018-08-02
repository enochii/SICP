(define (subsets lis)
  (if (null? lis)
      (list ())
      (let ((rest (subsets (cdr lis))))
        (append rest
                (map (lambda (x) (cons (car lis) x))
                     rest)))))
;;;print-subset
(define (print-subsets l)
  (define (helper lis)
    (display (car lis))
    (newline)
    (print-subsets (cdr l)))
  (if (not (null? l))
      (helper l)
      ))
;;;test
(print-subsets 
 (subsets (list 1 2 3)))

      
        