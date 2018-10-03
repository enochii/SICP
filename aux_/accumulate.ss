(define (accumulate combine init l)
  (if (null? l)
      init
      (combine (car l)
               (accumulate combine init (cdr l)))))