;;;2_1
;;;ought to work when n or d are negative.
(load "d:\\sicp\\chapter2\\rat.ss")

(define (make-rat n d)
  (let ((n-abs (abs n)) (d-abs (abs d)))
    (define gcd_ (gcd n-abs d-abs))
    (let ((n-abs (/ n-abs gcd_)) (d-abs (/ d-abs gcd_)))
      (if (> (* n d) 0)
          (cons n-abs d-abs)
          (cons (- n-abs) d-abs)))))
(display (make-rat 9 -6))
(display (make-rat -9 -6))
(display (make-rat -9 6))
;;;(-3 . 2) (3 . 2) (-3 . 2)