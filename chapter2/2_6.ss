;;;2.6 Church
(define zero (lambda (f) (lambda (x) x)))
;;;add-1
(define (add-1 n);;;maybe n is a procedure
  (lambda (f) (lambda (x) (f ((n f) x)))))
;;;one
(define one
  (lambda (f) (lambda (x) (f x))))
;;;two
(define two
  (lambda (f) (lambda (x) (f (f x)))))
;;;add
(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))
;;;test
(if (not (= (add zero two) (add zero two)))
    (display "zzzz"))
(define f
  (lambda (a)
    (lambda (b)
      (+ a b))))