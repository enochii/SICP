(define my-and
  '(define (and e1 e2)
     (if e1
         (if e2 true false)
         false)))
(define my-or
  '(define (or e1 e2)
     (if e1
         true
         (if e2 true false))))
(define xor
  '(define (xor e1 e2)
     (and (or e1 e2)
          (not (and e1 e2)))))
;
(pre-process xor)
(pre-process my-and)
(pre-process my-or)