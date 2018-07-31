;;;2.24
;(display (list 1 (list 2 (list 3 4))))
;;;answer->(1 (2 (3 4)))
;;;2.25
(define f (list 1 3 (list 5 7) 9))
(define s (list (list 7)))
(define t (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
;;;calculate 7

;(display 
 (car (cdr (car (cdr (cdr f)))))
 ;)
;(display 
 (car (car s))
 ;)
 (define (repeat n proc)
   (define (iter i)
     (if (= i 0)
         (lambda (x) (proc x))
         (lambda (x) (proc ((iter (- i 1)) x)))))
   (iter (- n 1)))
  (define f
    (repeat 6
            (lambda (x) (car (cdr x)))))
(display (f t))
;;;just to remember that the constant procedure return a list