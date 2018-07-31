(load "d:\\sicp\\chapter2\\2_18_reverse.ss")
;;
(define x (list (list 1 2) (list 3 4)))
(display x)
(newline)
(display (reverse x))

;;;deep-reverse
(define (deep-reverse y)
  (cond ((null? y) ())
        ((not (pair? y)) y)
        (else (append (deep-reverse (cdr y)) 
                      (list (deep-reverse (car y)))))))
;(define x (list 1 2 3 4))
(display (deep-reverse x))
(newline)
(define y (list (list (list 1 2) (list 3 4)) 5))
(display (deep-reverse y))

