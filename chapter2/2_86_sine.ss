;;2.86
(define (sine x)
  (apply-generic 'sine x))

;;internal procdure in scheme-number-packeage
(put 'sine '(scheme-number) sin)

;;... in real-package
(put 'sine '(real) sin)

;;... in rational-package
(define (sine-rational rat)
  (sin (/ (number rat) (denom rat))))
(put 'sine '(rational) sine-rational)
;;cosine is the same