;;e4.29
;;emmm, at first i think no need to make a independent moudle though i do,
;;and it seems to be convenient that i write an extra thunk-representation
;;to test the code.
;;and let's return this problem
(define (id x) (set! count (+ count 1)) x)
(define count 0)
(define (square x) (* x x))
;;
;;with memoization
;;100, 1

;;without
;;100, 2