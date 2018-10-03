;;book code -- 4.3.1
(define prime-sum-pair
  '(define (prime-sum-pair list1 list2)
     (let ((a (an-element-of list1))
           (b (an-element-of list2)))
       (require (prime? (+ a b)))
       (list a b)))
  )
;;require
'(define require
  ;'(define (require p)
  ;   (if (not p) (amb)))
)
(define an-element-of
  '(define (an-element-of items)
     (require (not (null? items)));a un-require will trigger a jump
     ;???????
     (amb (car items) (an-element-of (cdr items))))
  )

(define an-integer-starting-from
  '(define (an-integer-starting-from n)
     (amb n (an-integer-starting-from (+ n 1))))
  )