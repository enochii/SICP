;;assume that length of a is not bigger than b
(define (ripple-carry-adder a b c-in)
  (cond ((null? b);;end
         (cons c-in '()))
        ((null? a)
         (ripple-carry-adder (list (make-ware));;it will initialize with zero signal
                             b c-in))
        (else
         (let ((s (make-ware))
               (c-out (make-ware)))
           (full-adder (car a) (car b) c-in s c-out)
           (let ((result (ripple-carry-adder (cdr a) (cdr b) c-out))) 
             (cons (car result) (cons s (cdr result))))
           ))))
;;return (c-out s-list)