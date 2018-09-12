(load "d:\\sicp\\chapter2\\split-list.ss")
(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))
(define s
  (cons-stream 1
               (merge (scale-stream s 5)
                      (merge (scale-stream s 3)
                             (scale-stream s 2)))))
;;first we will get 2,3,5 from 1s
(display-stream (stream-map + (apply stream (build-list-from-num-val 4 0)) s))