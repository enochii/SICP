;;;for square
(load "D:\\sicp\\aux_\\math.ss")
;;;expmod
(define (expmod base exp m)
  (cond ((= 0 exp) 1)
        ((nontrivial-square-root? base m) 0)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base 
                       (expmod base (- exp 1) m)) m)
         )))
;;;nontrivial-square-root?
(define (nontrivial-square-root? base m)
  (and (not (= 1 base))
       (not (= (- m 1) base))
       (= (remainder (square base) m) 1)))
;;;non-zero-random
(define (non-zero-random n)
  (let ((r (random n)))
    (if (not (= r 0))
        r
        (non-zero-random n))))
;;;test
(define (Miller-Rabin-test n)
  (let ((times (ceiling (/ n 2))))
    (test-iter times n)))
(define (test-iter times n)
  (cond ((= times 0) #t)
        ((= (expmod (non-zero-random n) (- n 1) n) 1)
         (test-iter (- times 1) n))
        (else #f)))