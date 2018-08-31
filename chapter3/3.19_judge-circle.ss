;;u may see cycle-detection algorithm at https://en.wikipedia.org/wiki/Cycle_detection
(define (circle? a)
  (define (tortoise-hare tortoise hare)
    (cond ((or (null? tortoise) (null? hare) (null? (cdr hare)))
           #f)
          ((equal? tortoise hare)
           #t)
          (else
           (tortoise-hare (cdr tortoise) (cddr hare)))))
  (display "tortoise-hare alg -- ");(newline)
  (if (or (null? a) (null? (cdr a)))
      #f
      (tortoise-hare (cdr a) (cddr a))))