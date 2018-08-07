;(load "D:\\PLT\\collects\\errortrace\\errortrace-key.ss")
;(define-syntax du
;  (syntax-rules ()
;    ((_ expression unless condition)
;     (if (not condition) expression))))
;;
(define (flat-map f xs)
  (apply append (map f xs)))
(display (flat-map cdr '((1 2) (1 2))))
;(display (map car '((1 2) (1 2))))