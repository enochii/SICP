(load "d:\\sicp\\chapter3\\stream-operation.ss")
(define (stream-enumerate-interval a b)
  (if (> a b)
      the-empty-stream
      (cons-stream a
                   (stream-enumerate-interval (+ a 1) b))))
;(define xi (stream-enumerate-interval 0 10))
;(display-stream xi)
(define (show x)
  (display-line x)
  x)
;(define x (stream-map show (stream-enumerate-interval 0 10)))
;;0

;(stream-ref x 5)
;;1 2 3 4 5

;(stream-ref x 7)
;;6 7