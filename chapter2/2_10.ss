;;;2.10
(load "d:\\sicp\\chapter2\\2_7-8_sub-interval.ss")
;;;
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
;(display (mul-interval (make-interval 1 8) (make-interval -2 9)))

(define (div-interval x y)
  (let ((y-lower (lower-bound y))
        (y-upper (upper-bound y)))
    (if (or (= y-lower 0)
            (= y-upper 0)
            (and (< y-lower 0)
             (> y-upper 0)))
        (error "the second interval should not contain zero!" y)
        (mul-interval x (make-interval
                         (/ 1.0 y-upper)
                         (/ 1.0 y-lower))))))
;;;test div
(display (div-interval (make-interval -4 -2) (make-interval -3 6))) 