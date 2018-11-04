;(root left-child right-child)
;interfaces
(define (root tree) (car tree))
(define (left tree) (cadr tree))
(define (right tree) (caddr tree))
;
(define (preorder tree)
  (if (null? tree)
      'done
      (begin
        (display (root tree))(display " ")
        (preorder (left tree))
        (preorder (right tree))
        )))
(define (inorder tree)
  (if (null? tree)
      'done
      (begin
        (inorder (left tree))
        (display (root tree))(display " ")
        (inorder (right tree))
        )))
(define (postorder tree)
  (if (null? tree)
      'done
      (begin
        (postorder (left tree))
        (postorder (right tree))
        (display (root tree))(display " ")
        )))
;
(define (make-tree a b c)
  (list a b c))
;
(display "visit by recursion\n")
(load ".//test.ss")
(display "preorder\n")
(preorder tree-1)(newline)
(display "inorder\n")
(inorder tree-1)(newline)
(display "postorder\n")
(postorder tree-1)(newline)
(display "--------seperator--------\n")