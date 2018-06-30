;;(load "femat-test.ss")

;;look for the smallest divisor
(define (smallest-divisor n)
  (define (iter a)
    (if (= (remainder n a) 0) 
        a
        (iter (+ 1 a))
        ))
  (iter 2 ))

(define (isprime n)
  (= (smallest-divisor n) n))