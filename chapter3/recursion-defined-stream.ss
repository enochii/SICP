(load "d:\\sicp\\chapter3\\stream-operation.ss")
(load "d:\\sicp\\chapter3\\3.50_stream-map.ss")

(define (integers-starting-from n);;i just make
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))
;integers
(load "d:\\sicp\\aux_\\math.ss");;divides?
(define no-sevens
  (stream-filter (lambda (x) (not (divides? x 7)))
                 integers))
;(stream-ref no-sevens 100)
;;fib
(define (fibgen a b)
  (cons-stream a (fibgrn b (+ a b))))

;;sieve
(define (sieve candidates)
  (cons-stream (stream-car candidates)
               (sieve 
                (stream-filter 
                 (lambda (x) (not
                              (divides? x (stream-car candidates))))
                 (stream-cdr candidates)))))
(define primes (sieve (integers-starting-from 2)))
;;
(define infinite-stream-test
  (let ((control-times-helper (stream 1 1 1 1 1 1 1 1 1 1)))
    (display "i won't appear again!")(newline)
    (lambda (stream)
      (display-stream (stream-map * control-times-helper stream))
      'done)))
;(infinite-stream-test primes)

;;more fun here ...
(define ones (cons-stream 1 ones))
(define (add-streams s1 s2) (stream-map + s1 s2))
(define ints (cons-stream 1 (add-streams ones ints)))
;(infinite-stream-test ints)

(define fibs
          (cons-stream 0
                       (cons-stream 1
                                    (add-streams fibs
                                                 (stream-cdr fibs)))))
;(infinite-stream-test fibs)

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))
;;

(define primes
  (cons-stream
   2
   (stream-filter prime? (integers-starting-from 3))))
(define (primes? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) #t)
          ((divides? n (stream-car ps)) #f)
          (else (iter (stream-cdr ps)))))
  (iter primes))