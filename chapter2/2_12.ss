(load "d:\\sicp\\chapter2\\2_7-8_sub-interval.ss") 
(define (make-center-width x w)
  (make-interval (- x w) (+ x w)))
;;
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
;;;2.12
(define (make-center-percent x p)
  (make-interval (* (- 1 p) x) (* (+ 1 p) x)))
(define (percent i)
  (let ((u (upper-bound i)) (l (lower-bound i)))
     (/ (- u l) (+ u l))))
;;;test
(define t (make-center-percent 3 0.3))
;(display (center t))
;(newline)
;(display (percent t))