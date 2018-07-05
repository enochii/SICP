(load "d:\\sicp\\aux_\\math.ss")

;;look for the smallest divisor
(define (smallest-divisor n)
  (define (iter a)
    (if (> (square a) n)
        n
        (if (= (remainder n a) 0) 
        a
        (iter (+ 1 a))
        )
    )
    )
  (iter 2 ))

(define (prime? n)
  (if (or (= 0 n) (= 1 n))
      #f
      (= (smallest-divisor n) n)))