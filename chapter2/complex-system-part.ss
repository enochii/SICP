;;undefined
;;type-tag, attach-tag
(define (install-rectangular-package)
  ;;internal procedures
  (define (real-part_ z) (car z))
  (define (imag-part_ z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude_ z)
    (sqrt (+ (square (real-part_ z))
             (square (imag-part_ z)))))
  (define (angle_ z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;;interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part_)
  (put 'imag-part '(rectangular) imag-part_)
  (put 'magnitude '(rectangular) magnitude_)
  (put 'angle '(rectangular) angle_)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
;;......
;;install-polar-package the same
;;......

;;apply-generic
;;this procedure can be used to define real-part, imag-part, magnitude, 
;;angle
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for this types -- APPLY-GENERIC"
           (list op type-tags))))))

;;real-part
;;it can apply to a complex of which type is polar or rectangular
;;a little amazing, we can also use it in complex.the feel of overloading.
(define (real-part_ z)
  (apply-generic 'real-part z))
;;......
