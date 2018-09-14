(load ".//3.5.5.ss")

(load ".//display-stream.ss")
(define (rand-generator demand-stream)
  (define (responses ds rs)
    (cond ((stream-null? ds)
           the-empty-stream)
          ((eq? (stream-car ds) 'generate)
           (cons-stream
            (stream-car rs)
            (responses (stream-cdr ds) (stream-cdr rs))))
          ((eq? (stream-car ds) 'reset)
           (responses (stream-cdr ds) random-numbers))
          (else (error "Unknown demand -- RAND-GENERATOR"))))
  (responses demand-stream random-numbers))

;;
(display-stream random-numbers 5)
(define ds (stream 'generate 'generate 'generate 'reset
                   'generate 'generate 'generate 'reset
                   'generate))
(display-stream (rand-generator ds) 7)