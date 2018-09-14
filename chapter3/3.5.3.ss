;(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(load "d:\\sicp\\chapter3\\3.55_partial-sums.ss")
(define (sqrt-improve guess x)
  (average guess (/ x guess)))
;;
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map
                  (lambda (guess)
                    (sqrt-improve guess x))
                  guesses)))
  guesses)
;(infinite-stream-test (sqrt-stream 9))
;;
(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ 2 n)))))
;(infinite-stream-test (pi-summands 1))
;(infinite-stream-test (partial-sums ints))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))
;(infinite-stream-test pi-stream)

;;accelerate, good for alternating series
(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))
;(infinite-stream-test (euler-transform pi-stream))

(define (make-tableau transform s)
  (display "foolish me")
  (cons-stream s
               (stream-map transform
                           (make-tableau transform s))))
;;book version
(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform (transform s))))

(define pi-streams-streams
  (make-tableau euler-transform pi-stream))
(define pss pi-streams-streams)
;;
;(infinite-stream-test (stream-ref pss 0))
;(infinite-stream-test (stream-ref pss 1))
;(infinite-stream-test (stream-ref pss 2))
;(infinite-stream-test (stream-ref pss 4))
;(infinite-stream-test (stream-ref pss 6))

;;
(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

;(infinite-stream-test (accelerated-sequence euler-transform pi-stream))