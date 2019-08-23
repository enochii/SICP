(load ".//stack.ss")
(load ".//tree.ss")
;(load ".//test.ss")
;use stack to replace recursion
(define stack (make-stack))
;
(define (preorder-1 tree)
  (define (loop cp);cur
    (if (null? cp)
        'none
        (begin (display (root cp))(display " ")
               (if (not (null? (right cp)))
                   (push (right cp) stack))
               (cond ((not (null? (left cp)))
                      (loop (left cp)))
                     ((_empty? stack)
                      'done)
                     (else (let ((t (top stack)))
                             (pop stack)
                             (loop t)
                             ))
                     ))))
  (loop tree))
;
;
;
(define (inorder-1 tree)
  (define (backup)
    (if (_empty? stack)
        'done
        (let ((t (top stack)))
          (pop stack)
          ;(if (null? t) ???)
          (display (root t))(display " ")
          (loop (right t))
          )))
  (define (loop cp);;current ptr
    ;(push cp stack)
    (if (null? cp)
        (backup)
        (if (not (null? (left cp)))
            (begin (push cp stack) (loop (left cp)))
            (begin (display (root cp))(display " ")
                   ;(if (null? (right cp))
                    ;   (backup)
                       (loop (right cp))))));)
  (loop tree))
;
(define (not-tree? x)
  (not (or (pair? x) (equal? x '()))))
;postorder
(define (postorder-1 tree)
  ;(define (make-item tag value) (cons tag value))
  ;
  (define (pop-until...)
    (if (_empty? stack)
        'empty-stack
        (if (not-tree? (top stack))
            (begin (display (top stack))(display " ")
                   (pop stack)
                   (pop-until...)))
        ))
  (define (old-loop cp);current pointer
    (if (null? cp)
        (if (_empty? stack)
            'done
            (if (eq? 'empty-stack (pop-until...))
                'done
                (let ((t (top stack)))
                  (pop stack)
                  (old-loop t))))
        (begin (push (root cp) stack)
               (push (right cp) stack)
               (old-loop (left cp)))))
  ;
  (define (loop cp)
    (cond ((not (null? cp))
           (begin (push (root cp) stack)
               (push (right cp) stack)
               (loop (left cp))))
          ((_empty? stack) 'done)
          ((eq? 'empty-stack (pop-until...)) 'done)
          (else
           (let ((t (top stack)))
             (pop stack)
             (loop t)))))
           
  (loop tree))
;
(display "visit by stack\n")
(display "inorder\n")
(inorder-1 tree-1)
(clear stack)
;
(display "preorder\n")
(preorder-1 tree-1)
(clear stack)
;
(display "postorder\n")
(postorder-1 tree-1)
(clear stack)