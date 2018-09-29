;;e4.30
;;a) probably cause Ben's display is primitive procedure, which use actual-value 
;;   inside
;;b)
(manual-eval '
             (define (p1 x)
               (set! x (cons x '(2)))
               x)
             )
(manual-eval '
             (define (p2 x)
               (define (p e)
                 e
                 x)
               (p (set! x (cons x '(2)))))
             )
;;(p1 1) -> (1 2)
;;(p2 1) -> 1
(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval_ (car exps) env))
        (else (actual-value (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))
;;(p1 1) -> (1 2)
;;(p2 1) -> (1 2)
;
;;d) maybe Cy's will be more clear, but bug also can be a feature.good night-