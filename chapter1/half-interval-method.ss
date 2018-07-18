(load "d:\\sicp\\aux_\\math.ss")
(define (search f neg-p pos-p)
  (let ((mid-p (average neg-p pos-p)))
    (if (close-enough? neg-p pos-p)
        mid-p
        (let ((test-value (f mid-p)))
          (cond ((positive? test-value)wqeqds
                 (search f neg-p mid-p))
                ((negative? test-value)
                 (search f mid-p pos-p))
                (else mid-p))))))
;;;close-enough
(define (close-enough? a b)
  (< (abs (- a b)) 0.01))

;;;
(define (half-interval-mtd f a b)
  (let ((a-v (f a))
        (b-v (f b)))
    (cond ((and (negative? a-v) (positive? b-v))
           (search f a b))
          ((and (negative? b-v) (positive? a-v))
           (search f b a))
          (else
           (error "Value are not of oppositive sign" a b)))))
                