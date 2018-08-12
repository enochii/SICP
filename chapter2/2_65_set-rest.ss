(load "d:\\sicp\\chapter2\\list2tree.ss")
(load "d:\\sicp\\chapter2\\tree2list.ss")
(load "d:\\sicp\\chapter2\\pro-tree-set.ss")
(load "d:\\sicp\\chapter2\\sorted-set.ss")
;;2.65
(define (union-set_ s1 s2)
  (list->tree (union-set
              (tree->list-2 s1)
              (tree->list-2 s2))))
(define (intersection-set_ s1 s2)
  (list->tree (intersection-set
               (tree->list-2 s1)
               (tree->list-2 s2))))
;;test
(define l1 '(1 2 3 4 5))
(define l2 '(1 3 5 7 9))
(define t1 (list->tree l1))
(define t2 (list->tree l2))
;(display t1)
;(newline)
;(display t2)
;(newline)
;;wee use pro-list-tree, so we trans procedure-tree to list
(display (tree->list-2 (union-set_ t1 t2)))
(newline)
(display (tree->list-2 (intersection-set_ t1 t2)))
;;we can see that we use several procedures defined in 2.63 & 2.64
;;and their complexities are all O(n), so the complexity of final
;;combination is also O(n)