(define tree-1
  (make-tree
   'a
   (make-tree 'b (make-tree 'c '() '()) '())
   (make-tree 'd
              (make-tree 'e
                            (make-tree 'f '() '())
                            (make-tree 'g '() '()))
              (make-tree 'h
                         (make-tree 'i '() '())
                         (make-tree 'j '() '())))))
;
(define test-stack #f)
(define stack (make-stack))
(if test-stack
    (begin
      ;(define stack (make-stack))
      (push 'a stack)
      (push 'b stack)
      (push 'c stack)
      (push 'd stack)
      (pop stack)
      (push 'e stack)
      ;(clear stack)
      (pop stack)
      (pop stack)
      (pop stack)
      ;(pop stack)
      (pop stack)))