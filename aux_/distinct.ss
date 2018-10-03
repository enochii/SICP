(define (distinct? items)
  (if (null? (cdr items))
      #t
      (if (member (car items) (cdr items))
          #f
          (distinct? (cdr items)))))