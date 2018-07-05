;for prime check
(load "d:\\sicp\\chapter1\\prime.ss")

(define (runtime)
  (current-milliseconds))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-time n (- (runtime) start-time));no return value
      #f))
(define (report-time n elapsed-time)
  (display n)
  (display "***")
  (display elapsed-time)
  (newline)
  )

(define (search-for-primes n counter)
  (if (even? n)
      (s-f-p (+ n 1) counter)
      (s-f-p n counter)))

(define (s-f-p n counter)
  (if (> counter 0)
      (if (timed-prime-test n)
      (s-f-p (+ 2 n) (- counter 1))
      (s-f-p (+ 2 n) counter))
      "COMPUTE COMPLETE")
      )
  