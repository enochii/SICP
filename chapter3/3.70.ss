(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (let ((w1 (weight s1car))
                 (w2 (weight s2car)))
             (cond ((< w1 w2)
                    (cons-stream s1car 
                                 (merge-weighted (stream-cdr s1) s2 weight)))
                   ((or (> w1 w2)
                        (not (equal? s1car s2car)))
                    (cons-stream s2car 
                                 (merge-weighted s1 (stream-cdr s2) weight)))
                   (else
                    (cons-stream s1car (merge-weighted (stream-cdr s1)
                                                       (stream-cdr s2) weight)))
                   ))))))
(load "d:\\sicp\\chapter3\\display-stream.ss")
;(list a b) -> a < b
(define (weighted-pairs s t weight)
  (cons-stream 
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
    weight
    )))

;;
;a)
(define 370a
  (weighted-pairs ints ints (lambda (pair) (+ (car pair) (cadr pair)))))
;(display-stream 370a)
;;b)
(define (weight x) x)
(define _235
  (merge-weighted 
   (scale-stream ints 2)
   (merge-weighted
    (scale-stream ints 3)
    (scale-stream ints 5)
    weight)
   weight))
(define 370b
  (weighted-pairs _235 _235 (lambda (pair) (+ (* 2 (car pair))
                                              (* 3 (cadr pair))
                                              (* 5 (car pair) (cadr pair))))))
;(display-stream 370b)