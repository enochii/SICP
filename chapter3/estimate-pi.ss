;;boring-rand
(define random-init 1214)
(define (rand-update x)
  (define a (+ (* 4 (- (expt 2 16) 1)) 1))
  (define b (+ 1 (* 2 (- (expt 2 17) 1))))
  (define m (- (expt 2 32) 1))
  ;(display (list a b m))
  (remainder (+ b (* a x)) m))
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))
;(rand-update 3)
;test
(rand)
(rand)
(rand)
;;estimate-pi
(define (estimate-pi trials)
  (sqrt (/ 6 (monter-carlo trials cesaro-test))))
(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))
(define (monter-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= 0 trials-remaining)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ 1 trials-passed)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))
;(estimate-pi 100000)
;;output - > 2.8978812641819207