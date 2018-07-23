;;;2.2
;;;display
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))
;;;segment
(define (make-segment sp ep);;;start-point end-point
  (cons sp ep))
(define (start-segment seg)
  (car seg))
(define (end-segment seg)
  (cdr seg))
;;;point
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

;;;average
(load "d:\\sicp\\aux_\\math.ss")

;;;mid-point
(define (mid-point seg)
  (let ((mid-x (average (x-point (start-segment seg))
                        (x-point (end-segment seg))))
        (mid-y (average (y-point (start-segment seg))
                        (y-point (end-segment seg)))))
    (make-point mid-x mid-y)))
;;;test
(define seg (make-segment (make-point 1 6)
                          (make-point 2 4)))
(display (mid-point seg))