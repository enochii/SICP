;;;2.7
(define (make-interval x y)
  (cons x y))
(define (lower-bound z)
  (car z))
(define (upper-bound z)
  (cdr z))

;;;2.8
(define (sub-interval a b);;;both a and bare intervals
  (make-interval (- (lower-bound a) (upper-bound b))
                 (- (upper-bound a) (lower-bound b))))

;;;test
;(display (sub-interval (make-interval 2 8) (make-interval 1 10)))