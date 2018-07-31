(define one-through-four (list 1 2 3 4))
;(display (car one-through-four))
;(newline)
;(display (cdr one-through-four))
;;;list-ref
;;;item--->list
;;;n--->index
(define (list-refer items n)
  (define (iter lis i)
    (if (= i 0) 
         (car lis)
         (iter (cdr lis) (- i 1))
         )
    )
  (iter items n))
;(list-refer one-through-four 0)
;(list-refer one-through-four 1)
;(list-refer one-through-four 2)
;(list-refer one-through-four 3)
;(length one-through-four)
(define (len l)
  (if (null? l)
      0
      (+ 1 (len (cdr l)))))
(len one-through-four)
(len (cons 2 one-through-four))
;
(define (app l1 l2)
  (if (null? l1) 
      l2
      ;((null? (cdr l1)) (cons (car l1) l2))      
      (cons (car l1) (app (cdr l1) l2))))
;;test
;(display 
 (app one-through-four one-through-four)
 ;)