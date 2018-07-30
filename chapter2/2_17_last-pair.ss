;;;2.17
(load "d:\\sicp\\chapter2\\list_base.ss")

;;;last-pair
(define (last_pair l)
  (define (iter lis)
    (if (null? (cdr lis))
        (car lis)
        (last-pair (cdr lis))))
  (if (null? l)
      (error "list" l "is empty")
      (iter l)))
