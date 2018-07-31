;;;scale
(define nil (list))
(define (scale-list items factor)
  (if (null? items)
      nil
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))
;(display (scale-list (list 1 2 3 4 5) 10))
;;;map
(define (map_ proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map_ proc (cdr items)))))
(display (map_ (lambda (x) (* x x))
               (list 1 2 3 4)))
