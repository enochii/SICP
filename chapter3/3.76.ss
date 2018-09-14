(define (smooth input-stream)
  (stream-map (lambda (x y) (/ (+ x y) 2))
              input-stream
              (stream-cdr input-stream)))
;;
(define (make-zero-crossings input-stream last-value smooth)
  (define (mzc-iter smoothed-stream last-value)
    (cons-stream
     (sign-change-detector (stream-car smoothed-stream) last-value)
     (mzc-iter (stream-cdr smoothed-stream) (stream-car smoothed-stream))))
  (mzc-iter (smooth (cons-stream last-value input-stream)) last-value))