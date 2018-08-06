(define (tree-depth tree)
  (if (list? tree)
      (+ 1 (apply max (map tree-depth tree)))
      0))
(define tree '(A B C (D (F H) G) E))
;;for a tree represented by a list, the first value is it's root
;;the defination of root of sub-tree is the same recursively
(tree-depth tree)