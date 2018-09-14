(define (stream-limit stream tolerance)
  (let ((item1 (stream-car stream))
        (item2 (stream-car (stream-cdr stream))))
    (if (< (abs (- item1 item2)) tolerance)
        item2
        (stream-limit (stream-cdr stream) tolerance))))
;;
(load "d:\\sicp\\chapter3\\3.5.3.ss")
(define (sqrt_ x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
(sqrt_ 2 0.000001)