(define (double f)
  (lambda (x)
    (f (f x))))

;;;inc
(define (inc x)
  (+ 1 x))

;;;21 (2^2)^2 = 16
(((double (double double)) inc) 5)
