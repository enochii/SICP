(load "d:\\sicp\\chapter1\\1_37.ss")

;;;procedure n
(define (n i)
  1.0)
;;;procedure d
(define (d i)
  (if (= (remainder (+ i 1) 3) 0)
      (* (/ (+ i 1) 3) 2)
      1))
;;;calculate e
(define (cal-e k)
  (+ (cont-frac n d k) 2))