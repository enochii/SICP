(load "d:\\sicp\\chapter3\\3.51_stream-map-response.ss");;enumerate-interval
(load "d:\\sicp\\chapter3\\stream-operation.ss")
(define sum 0)
(define (accum x)
  (set! sum (+ sum x))
  sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;;1
(display sum)(newline)

(define y (stream-filter even? seq))
;;6
(display sum)(newline)

;(display-stream seq)
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
;;10
(display sum)(newline)

;(stream-cdr z)
;(display sum)(newline)

(stream-ref y 7)
;;136
(display sum)(newline)

;(display-stream z)
;;210

;;1 3 6 10 15 21 
;(cons-stream 1 (cons 1 (display "xixi")))
(cons-stream (stream-car seq) (stream-cdr seq))