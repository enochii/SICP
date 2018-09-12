(define (memo-proc proc)
  (let ((already-run? #f)
        (result #f))
    (lambda ()
      (if (not already-run?)
          (begin (set! already-run? #t)
                 (set! result (proc))
                 result)
          result))))
(define (delay_ exp)
  (memo-proc (lambda () exp)))
(define (force_ delayed-object)
  (delayed-object))
;;
'self-defined-delay
(delay_ (display "if i delay, u won't see me"))

'scheme-delay
(define xi (delay (display "if i delay, u won't see me unless force me")))
(force xi)