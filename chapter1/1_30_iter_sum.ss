;;;1_30
;;;迭代代替线性递归
;;;load
(load "d:\\sicp\\chapter1\\general-sum.ss")
(define (iterative-sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))