(load "d:\\sicp\\chapter3\\estimate-pi.ss")
(load "d:\\sicp\\chapter3\\stream-operation.ss")
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (random-update x))
      x)))

(define (map-successive-pairs f s)
  (cons-stream
   (f (stream-car s) (stream-car (stream-cdr s)))
   (map-successive-pairs f
                         (stream-cdr (stream-cdr s)))))

(define random-numbers
  (cons-stream
   random-init
   (stream-map rand-update random-numbers)))
(define cesaro-stream
  (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1))
                        random-numbers))
;;
(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
      (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ 1 passed) failed)
      (next (+ 1 passed) (+ 1 failed))))

(define pi
  (stream-map (lambda (p) (sqrt (/ 6 p)))
              (monte-carlo cesaro-stream 0 0)))
;(stream-ref pi 100000)