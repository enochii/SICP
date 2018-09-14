(load "d:\\sicp\\chapter3\\prime-sum-pairs.ss")
(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
    (interleave
     (stream-map (lambda (x) (list x (stream-car t))) (stream-cdr s))
     (pairs (stream-cdr s) (stream-cdr t))))))
;;
(display-stream (pairs ints ints))
;;divide the table into 4 parts
;;0.intersection of first-row and first-column
;;1.first-row except 0
;;2.first-column except 0
;;3.the table removed first-column and first-row