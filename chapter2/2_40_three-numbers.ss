;;
(load "d:\\sicp\\chapter2\\list_operation.ss")
(load "d:\\sicp\\chapter2\\flatmap.ss")
(define (unique-lists n)
    (flatmap (lambda (i)
           (flatmap (lambda (j)
                  (map (lambda (k)
                         (list i j k))
                       (enumerate-interval 1 (- j 1))))
                (enumerate-interval 1 (- i 1))))
         (enumerate-interval 1 n)))
(define (bor n s)
  
  (filter (lambda (lists)
            (< (+ (car lists) (cadr lists) (caddr lists)) s))
          (unique-lists n)))
;;;
;(display (unique-lists 5))
(display (bor 5 10))
;;;BECARE:just to be sure the difference of map and flatmap
