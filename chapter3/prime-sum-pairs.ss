;(load "d:\\sicp\\chapter3\\stream-operation.ss")
(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
               (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))
;;
(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))
(load "d:\\sicp\\chapter1\\prime.ss")
(define int-pairs (pairs ints ints))
(define prime-sum-pairs
  (stream-filter (lambda (pair)
                   (prime? (+ (car pair) (cadr pair))))
                 int-pairs))
(load "d:\\sicp\\chapter3\\display-stream.ss")
;(display-stream int-pairs 1000)
;(display-stream prime-sum-pairs)