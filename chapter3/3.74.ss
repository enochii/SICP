(load "d:\\sicp\\chapter3\\stream-operation.ss")
(load "d:\\sicp\\chapter3\\3.50_stream-map.ss")
(load "d:\\sicp\\chapter3\\display-stream.ss")
(define sense-data (stream 1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4 '...))
(define (sign-change-detector sch sb)
  (cond ((and (< sch 0) (>= sb 0)) -1);;remember to tranfer the position of 1 
        ((and (>= sch 0) (< sb 0)) 1);;and -1, cause when call detector, the
        (else 0)));;;;;;order of arguments is reversed! resulting from extra 0
(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))
(define zero-crossings (make-zero-crossings sense-data 0))
;;
(define zero-crossings-
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))
'Alyssa
(display-stream zero-crossings 12)
'Boss
(display-stream zero-crossings- 12)