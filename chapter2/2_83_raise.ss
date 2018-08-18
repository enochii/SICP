;;(define 傻逼 '傻逼)
;;傻逼

;;2.83
;;still just 3 types -> scheme-number, rational, complex
(define (install-raise-package)
  (define (raise-scheme-number;;-rational
           x)
    (make-rational (contents x) 1))
  
  ;;
  (define (raise-rational rat)
    (let ((ct (contents rat)))
      (make-rational;;if have
       (/ (number (contents rat)) (denom (contents rat))))))
  (define (raise-real x)
    (make-complex-from-real-imag (contents x) 0))
  
  (put 'raise '(scheme-number)
       raise-scheme-number)
  ;;
  (put 'raise '(rational)
       raise-rational)
  ;;
  (put 'raise '(real)
       raise-real)
  'done)
(define (raise_ x)
  (apply-generic 'raise x))