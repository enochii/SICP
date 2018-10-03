;prime?
;
(define prime?
  '(define (prime? x)
     (define (iter step)
       (cond ((> (* step step) x) true)
             ((= (remainder x step) 0) false)
             (else (iter (+ step 1)))))
     (cond ((< x 2)
            false)
           ((= x 2)
            true)
           (else
            (iter 2)))))