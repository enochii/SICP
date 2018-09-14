(load "d:\\sicp\\aux_\\math.ss")
(load "d:\\sicp\\chapter3\\3.70.ss")
(define (ram-weight pair) (+ (cube (car pair)) (cube (cadr pair))))
(define (search-ram s)
  (if (= (ram-weight (stream-car s))
         (ram-weight (stream-car (stream-cdr s))))
      (cons-stream (ram-weight (stream-car s))
                   (search-ram (stream-cdr s)))
      (search-ram (stream-cdr s))))
(define ram-stream
  (search-ram (weighted-pairs ints ints
                              ram-weight)))
(display-stream ram-stream)
;;4104 13832 20683 32832 39312