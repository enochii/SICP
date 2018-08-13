(load "d:\\sicp\\chapter2\\hfm-tree.ss")
(define hfm-tree (cadr (hfm elts)))
(define bits '(1 0 1 0 ;;cbahefgd
                 1 1 0 1 
                 1 1 0 0 
                 0
                 1 0 0 0
                 1 0 0 1
                 1 1 1
                 1 0 1 1))

(define (decode bits tree)
  (define (decode-1 rest sub-tree)
    ;;when we approach a leaf-node, we need to print it and make
    ;;the sub-tree be the oringinal hfm-tree
    (cond ((null? rest) (list sub-tree))
          ((symbol? sub-tree)
           (cons sub-tree (decode-1 rest tree)))
          ((list? sub-tree)
           (let ((code (car rest)))
             (cond ((= code 0) 
                    (decode-1 (cdr rest) (car sub-tree)))
                   ((= code 1) 
                    (decode-1 (cdr rest) (cadr sub-tree)))
                   (else (error "unknown code" code)))))))
  (decode-1 bits tree))
;;test
;(display (decode bits hfm-tree))