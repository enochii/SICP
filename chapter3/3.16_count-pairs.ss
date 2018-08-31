(define (count-pairs x)
  (if (pair? x)
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)
      0))
;(load "d:\\sicp\\chapter3\\3.17_count-pairs.ss")
;;3
(count-pairs '(1 2 3))
;;
;;4
(define x '(foo))
(define z (cons x x))
(count-pairs (list z))
;;
;;7
(count-pairs (cons z z))
;;
;;xixi
(define xi '(1 2 3))
;(count-pairs (set-cdr! (cddr xi) xi))
;;it's a pity that set-cdr! procedure is not supported in my scheme
;;environment

(memq (list 2 3) (list 1 (list 2 3)))
;why the result of above code is #f?
;;
;;updated count-pairs in 3.17 also has bugs, cause it regard the equal '(1)
;;as the same thing
(define xixi (cons (list 1) (list 1)))
(count-pairs xixi)