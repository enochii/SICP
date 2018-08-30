(define f
  (let ((first-time? #t))
    (lambda (x)
      (if first-time?
          (begin (set! first-time? #f)
                 x)
          0))))
(f 9);9
(f 9);0
(f 9);0
(+ (f 0 ) (f 1));0 from left to right
;;when u call f at first time, it return the argument, otherwise zero.
;;so we can analyze the eval order of argument.