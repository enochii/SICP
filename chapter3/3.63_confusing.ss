;;redefine delay and cons-stream
;;it can recover the constant delay
(define-syntax delay_
  (syntax-rules ()
    ((delay_ exp)
     (begin ;(display "delay")
            (lambda () exp)))
    ))
(define-syntax force_
  (syntax-rules ()
    ((force_ delayed-object)
     (begin ;(display "force")
            (delayed-object)))
    ))
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream x y)
     (cons x (delay_ y)))))
  
(define (stream-cdr z) (force_ (cdr z)))
(define (stream-car z) (car z))
;;
(define a
  (cons-stream (begin (display "a")(newline) 1)
               a))
(define (b)
  (cons-stream (begin (display "(b)")(newline) 1)
               (b)))

(load "d:\\sicp\\chapter3\\display-stream.ss")
(display-stream a 5)
(display-stream (b) 5)
;;delay defined above return type <#procedure> rather than <#promise>, so we need
;;to redefine force too.

;(force (delay (display "xixixi")))