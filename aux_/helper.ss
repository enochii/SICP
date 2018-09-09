(define (output . list)
  (map (lambda (x) (display x)(display " ")) list)
  (newline))

;;error is not supported in r5rs
(define (error . list)
  (output (cons 'error! list)))
;(error 'sch 'is 'a 'sb)