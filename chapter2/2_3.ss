;;;2.3   rectangle
;;;we can express rectangle by a pair of points, which
;;;are the left-top and right-bottom point,also, we can
;;;use a pair of segments to represent it.

;(define (make-rect-bp p1 p2);;;make point by points
;  (if (< (car p1) (car p2))
;      (cons p1 p2)
;      (cons p1 p2)))
;(define (lt-point rect)
;  (car rect))
;(define (rb-point rect)
;  (cdr rect))

;;;use segments
(define (make-rect-bs len wid)
  (cons len wid))
(define (length-rect rect)
  (car rect))
(define (width-rect rect)
  (cdr rect))

(define (make-rect-bp p1 p2)
  (define p3 (make-point (car p1) (cdr p2)))
  (let ((seg1 (make-segment p1 p3))
        (seg2 (make-segment p2 p3)))
    (make-rect-bs seg1 seg2)))
;;;load
(load "d:\\sicp\\chapter2\\2_2.ss")

(define (length-segment seg)
  (let ((p1 (car seg))
        (p2 (cdr seg)))
    (sqrt  (+ (square (- (car p1) (car p2)))
              (square (- (cdr p1) (cdr p2)))))))
;;;test
;(length-segment (make-segment (make-point 1 6)
;                             (make-point 2 7)))
(define (area-rect rect)
  (* (length-segment (length-rect rect))
     (length-segment (width-rect rect))))
(define (cir-rect rect)
  (* 2 (+ (length-segment (length-rect rect))
          (length-segment (width-rect rect)))))
(define p1 (make-point 1 3))
(define p2 (make-point 2 2))
(define p3 (make-point 1 2))
(define rect1 (make-rect-bp p1 p2))

(display (area-rect rect1))
(newline)
(display (cir-rect rect1))
;;;u may notice that we use the procedure make-rect-by-segment
;;;to define make-rect-by-points, this can provide the consis-
;;;tance so we can easily define area and cir