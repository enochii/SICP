;;;load repeated procedure
(load "d:\\sicp\\chapter1\\1_43.ss")
(load "d:\\sicp\\aux_\\math.ss")

;;;1_44
(define dx 0.00001)
(define (smooth f)
  (lambda (x) (/ (+ (f x)
                    (f (- x dx))
                    (f (+ x dx))) 3)))
;;;smooth n times
;;;BECARE: repeat n times is for procedure smooth, not value x
(define (smooth-nt f n)
  ;(let ((helper 
  ((repeated smooth n) f));)
    ;helper))
;((smooth-nt square 10) 5)