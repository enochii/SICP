;;distinct?, abs, member
(define distinct?
  '(define (distinct? items)
     (cond ((null? items) true)
           ((null? (cdr items)) true)
           ((member (car items) (cdr items)) false)
           (else (distinct? (cdr items))))))
;
(define member?;;to avoid conflict with constant identitifier
  '(define (member item items)
     (cond ((null? items) false)
           ((equal? item (car items)) true)
           (else (member item (cdr items))))))
;
(define myabs
         '(define (abs xi)
            (if (< xi 0)
                (- xi)
                xi)))
(pre-process myabs)
(pre-process member?)
(pre-process distinct?)