;;;2.11
;;;(* 3 3) => 9
;;;each interval has 3 states : 1.all negative 2.all positive
;;;3.negative and positive. also, as for the state that one
;;;bound is zero, we can include it into above state that fits.
(load "d:\\sicp\\chapter2\\2_7-8_sub-interval.ss")
(define (mul-interval x y)
  (let ((x-low (lower-bound x))
        (x-up (upper-bound x))
        (y-low (lower-bound y))
        (y-up (upper-bound y)))
    (define (logo low up);;;to find the interval which state is
      (cond (;(and (< low 0)
                  (<= up 0);)
             -1)
            ((and (< low 0)
                  (> up 0))
             0)
            (else
             1)))
    ;;;we say mul-interval has 9 states, actully, cause of the symmetry of x and y,
      ;;;it just has 6 states, and we use the procedure dispatch to calculate it
      (define (dispatch a b)
        (cond ((and (= -1 a) (= 0 b))
               0)
              ((and (= -1 a) (= 1 b))
               1)
              ((and (= -1 a) (= -1 b))
               2)
              ((and (= 0 a) (= 1 b))
               3)
              ((and (= 0 a) (= 0 b))
               4)
              ((and (= 1 a) (= 1 b))
               5)))
    (let ((x-logo (logo x-low x-up))
          (y-logo (logo y-low y-up))
          )
      (if (> x-logo y-logo)
          (mul-interval y x);;;if-clause promise that x-logo < y-logo
      
      (let ((xixi (dispatch x-logo y-logo)))
      (cond ((= xixi 0)
             (make-interval (* x-low y-up) (* x-low y-low)))
            ((= xixi 1)
             (make-interval (* x-up y-up) (* x-low y-low)))
            ((= xixi 2)
             (make-interval (* x-up y-up) (* x-low y-low)))
            ((= xixi 3)
             (make-interval (* x-low y-up) (* x-up y-up)))
            ((= xixi 4);;;i think this case also needs 4 mults
             (make-interval (min (* x-low y-up) (* x-up y-low))
                            (max (* x-low y-low) (* x-up y-up))))
            ((= xixi 5)
             (make-interval (* x-low y-low) (* x-up y-up)))))))))
;;;test
;(display (mul-interval (cons 2 6) (cons -2 4)))