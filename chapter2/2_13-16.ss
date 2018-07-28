(load "d:\\sicp\\chapter2\\add-interval.ss")
(load "d:\\sicp\\chapter2\\2_7-8_sub-interval.ss")
(load "d:\\sicp\\chapter2\\2_11_mul-interval.ss")
(load "d:\\sicp\\chapter2\\2_10.ss")
;;
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
;;
(define (par2 r1 r2)
  (define one (make-interval 1 1))
  (div-interval one
                (add-interval (div-interval one r1)
                              (div-interval one r2))))
(define (print-test r1 r2)
  (display (par1 r1 r2))
  (newline)
  (display (par2 r1 r2)))
(load "d:\\sicp\\chapter2\\2_12.ss")
(define r1 (make-center-width 3 0.03))
(define r2 (make-center-width 4 0.04))
(print-test r1 r2)

;;;相同代数式产生不同结果的原因：考虑区间A，A/A=>1，然而由公式计算出来应该是[A-min/A-max,A-max/A-min]
  