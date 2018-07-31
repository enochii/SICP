(define x (cons (list 1 2) (list 3 4)))
(length x)

(define (count-leaves x)
  (cond ((null? x) 0)
        ((pair? x) (+ (count-leaves (car x))
                      (count-leaves (cdr x))))
        (else 1)))
;;;test
(count-leaves x)