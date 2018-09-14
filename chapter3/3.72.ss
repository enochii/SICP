(load "d:\\sicp\\chapter3\\3.70.ss")
(define (weight372 pair) (+ (square (car pair)) (square (cadr pair))))
(define (search372 s)
    (if (and (= (weight372 (stream-car s))
                (weight372 (stream-car (stream-cdr s))))
             (= (weight372 (stream-car (stream-cdr s)))
                (weight372 (stream-car (stream-cdr (stream-cdr s))))))
        (cons-stream 
         (weight372 (stream-car s))
         (search372 (stream-cdr s)))
        (search372 (stream-cdr s))))
(define _372
  (search372 (weighted-pairs ints ints weight372)))
;;
(display-stream _372)