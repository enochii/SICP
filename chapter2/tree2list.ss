;;2.63
;(load "d:\\sicp\\chapter2\\pro-tree-set.ss")
(define (tree->list-1 tree)
  (if (nil-leaf? tree)
      '()
      (append (tree->list-1 (left-branch tree))
               (cons (entry tree)
                     (tree->list-1 (right-branch tree))))))
;;
(define t (make-tree 6 
                     (make-tree 4 
                                (make-tree 3 '() '()) (make-tree 5 '() '())) 
                     (make-tree 7 '() '())
                     ))
(define t1 (make-tree 4 (make-tree 3 t t) (make-tree 3 t t)))
;(display t)
;;(display (tree->list-1 (make-tree 3 '() '())))
;;(newline)
;;(display (tree->list-1 t))
;;
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))
;;
;;(display (tree->list-2 t))
(load "d:\\sicp\\aux_\\time.ss")
(define (print-time tree->list start-time)
  (tree->list t1)
  (display (- (runtime) start-time)))
;;
;(print-time tree->list-1 (runtime))
;(print-time tree->list-2 (runtime))
;;the test cannot show the difference cause that t1 is too simple.
;;answer says that version1 -> nlog(n)
;;                 version2 -> n
;;considering the time complexity of cons and append
  