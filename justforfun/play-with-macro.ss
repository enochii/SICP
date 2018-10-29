;感觉macro就是模式匹配？
(define-syntax def
  (syntax-rules ()
    ((_ n e)
     (define n e))
    ((_ n e1 e2 ...)
     (define n
       (begin e1 e2 ...)))
    ((_ (f x ...) e1 ...)
     (define (f x ...)
       e1
       ...))

    ))
;
(def (fact n) (display "hhhh") (if (= n 1) 1 (* n (fact (- n 1)))))