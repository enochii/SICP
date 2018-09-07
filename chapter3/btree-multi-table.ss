;;tree-structure -> '((key . entry) left-subtree right-subtree))
;;left-subtree and left-subtree are just like there parents
(define (make-tree key value left-subtree right-subtree)
  (list (cons key value) left-subtree right-subtree))
;;maybe we have to make a empty-tree logo, cause it's easier to
;;change the tree structure.actually, if we don't do this, i don't
;;know how to change the internal structure of tree, in my eyes, tree
;;as a argument is just like a pointer in c++
(define (make-leaf) (list 'nil))
;;if u do like this
;;(define (make-leaf) '(nil))
;;all the (make-leaf) point to the same '(nil), f__k
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;tree structure diagram -> 
;;((key . (value . next-layer-tree-structre)) left-subtree right-subtree)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;get
(define (get-entry tree) (car tree))
(define (get-left tree) (cadr tree))
(define (get-right tree) (caddr tree))
(define (get-next-layer tree) (cddar tree))
;;
;(define (set-left! tree new-left)
  ;(set-car! (cdr tree) new-left))
;(define (set-right! tree new-right)
  ;(ser-car! (cddr tree) new-right))
;(define (set-entry! tree new-entry)
  ;(set-car! tree new-entry))
;;
(define less <);;
(define (leaves? x) (null? (cdr x)));;filter the empty-tree logo
;(define (place-holder) #f)
(define (lookup keys tree)
  (cond ((leaves? tree) #f)
        ((equal? (car keys) (caar tree))
         (if (null? (cdr keys))
             (cadr (get-entry tree))
             (lookup (cdr keys) (cddr (get-entry tree)))))
        ((less (car keys) (caar tree))
         (lookup keys (get-left tree)))
        (else
         (lookup keys (get-right tree)))))
;;
(define (insert! keys value tree)
  (cond ((null? (cdr keys))
         ;(display "case 1")
         (let ((new-item (make-tree 
                          (car keys)
                          (cons value (make-leaf))
                          (make-leaf) (make-leaf))))
           (insert-proc new-item tree)));;will do the upgrade job
        ((leaves? tree)
         ;(display tree)
         (let ((new-item (make-tree 
                          (car keys)
                          (cons #f (make-leaf))
                          (make-leaf) (make-leaf))))
           (begin (set-car! tree (car new-item))
                  (set-cdr! tree (cdr new-item))
                  ;(display (get-next-layer tree))
                  ;(display tree)
                  (insert! (cdr keys) value (get-next-layer tree)))))
        ((equal? (car keys) (car (get-entry tree)))
         ;(display "case 3")
         (insert! (cdr keys) value (get-next-layer tree)))
        ((less (car keys) (get-key tree))
         ;(display "case 4")
         (insert! keys value (get-left tree)))
        ((less (get-key tree) (car keys))
         ;(display (car (get-entry tree))) (newline) (display (car keys))
         ;(display "case 5")
         (insert! keys value (get-right tree)))
        (else (error "break! -- INSERT!"))))
;;
(define (upgrade-value tree new-value)
  (set-car! (cdar tree) new-value))
(define (get-key tree) (caar tree))
(define (get-value tree) (cadar tree))
(define (insert-proc new-item tree)
  (cond ((leaves? tree)
         (begin (set-car! tree (car new-item))
                (set-cdr! tree (cdr new-item))))
        ((equal? (get-key tree) (get-key new-item));;upgrade
         ;(display (get-key tree))(newline)(display (get-key new-item))(newline)
         (upgrade-value tree (get-value new-item)))
        ((less (get-key new-item) (get-key tree))
         (insert-proc new-item (get-left tree)))
        (else
         (insert-proc new-item (get-right tree)))))
;;