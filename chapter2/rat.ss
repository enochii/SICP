(define (add-rat x y)
  (make-rat (+ (* (number x) (denom y))
               (* (number y) (denom x)))
            (* (denom x) (denom y))))
;;;use add to define sub
(define (sub-rat x y)
  (add-rat x (- y)))

(define (mul-rat x y)
  (make-rat (* (number x) (number y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (number x) (denom y))
            (* (number y) (denom x))))

(define (equal-rat? x y)
  (= (* (number x) (denom y))
     (* (number y) (denom x))))
;;;cons
(define (make-rat n d)
  (let ((gcd_ (gcd n d)))
    (cons (/ n gcd_) (/ d gcd_))))

(define (number x) (car x))
(define (denom x) (cdr x))

;;;display
(define (print-rat x)
  (newline)
  (display (number x))
  (display "/")
  (display (denom x)))

;;;test
(define one-half (make-rat 1 2))
;(print-rat one-half)
;(print-rat (make-rat 9 6))
;1/2

