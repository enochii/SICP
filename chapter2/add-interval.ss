(load "d:\\sicp\\chapter2\\2_7-8_sub-interval.ss")
(define (add-interval a b)
  (make-interval (+ (lower-bound a) (lower-bound b))
                 (+ (upper-bound a) (upper-bound b))))