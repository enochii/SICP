;;specify recursive procedures without using letrec or define, a little cool.
;;e4.21
;;factorial
((lambda (fact n)
   (fact fact n))
 (lambda (ft k)
   (if (= k 1)
       1
       (* k (ft ft (- k 1)))))
 10)
;;a)
((lambda (fib n)
   (fib fib n))
 (lambda (fb k)
   (if (<= k 1)
       k;;0, 1
       (+ (fb fb (- k 1))
          (fb fb (- k 2)))))
 7)
;;b)
(define (f x)
  ((lambda (even odd n)
     (even even odd n))
   (lambda (ev od k)
     (if (= k 0)
         #t
         (od od ev (- k 1))))
   (lambda (od ev k)
     (if (= k 0)
         #f
         (ev ev od (- k 1))))
   x))
(f 1)
(f 2)
(f 3)
(f 11)
(f 12)
(f 13)
(f 111)
(f 112)
(f 113)
;;the trick is that we actually use a argument-name to bind a lambda