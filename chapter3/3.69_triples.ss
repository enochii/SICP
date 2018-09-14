(load "d:\\sicp\\chapter3\\prime-sum-pairs.ss")
(load "d:\\sicp\\aux_\\math.ss")
;;the code actully base on that s, t, u are the same series
;;or u can't simply divide it into 3 parts below. for example,
;;in case of they are different, we should also consider cases
;;such like (list (cadr s) (car t) (car u)), but we just omit it
(define (triples s t u)
  (cons-stream
   (list (stream-car s) (stream-car t) (stream-car u))
   (interleave
    (stream-map (lambda (pair) (cons (stream-car s) pair))
                (stream-cdr (pairs t u)))
    (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))
;;
(define _369
  (stream-filter (lambda (list) (= (+ (square (car list)) (square (cadr list)))
                                   (square (caddr list))))
                 (triples ints ints ints)))
;;
(load "d:\\sicp\\chapter3\\display-stream.ss")
(display-stream _369 5)