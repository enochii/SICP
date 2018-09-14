(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ last-value (stream-car input-stream)) 2)))
    (cons-stream (sign-change-detector avpt last-avpt)
                 (make-zero-crossings (stream-cdr input-stream)
                                      (stream-car input-stream)
                                      avpt))))
;;or we can save last-value, which don't have to add a argument
(define (mzc-iter input-stream last-avpt)
  (let ((avpt 
         (/ (+ (stream-car input-stream) 
               (stream-car (stream-cdr input-stream))) 
            2)))
    (cons-stream (sign-change-detector last-avpt avpt)
                 (mzc-iter (stream-cdr input-stream) avpt))))
(define (mzc input-stream last-value);;use the first last-value to be first avpt
  (mzc-iter (cons-stream last-value input-stream) last-value))