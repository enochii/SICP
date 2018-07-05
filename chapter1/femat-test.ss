(define (square a)
  (* a a))

;;calculate the result of (a^n)mod n(a<n&&a>0)
(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder
                      (square 
                       (remainder 
                               (expmod base (/ exp 2) n)
                               n)
                       )
                      n))
        (else (remainder 
               (* base (remainder
                        (square (remainder (expmod base (/ (- exp 1) 2) n) n))
                        n)) n))))

;;main logic
(define (femat-test n times)
  (define (try-once a n)
    (= (expmod a n n) a))
  (cond ((= times 0) true)
        ((try-once (+ 1 (random (- n 1))) n) (femat-test n (- times 1)))
        (else false)))