;;e4.22 do it in 4.1.7.ss
;;e4.23
;;in Alyssa's version, the loop job will be done again and again when called.
;;
(define (analyze-sequence exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs)) ((car procs) env))
          (else
           ((car procs) env)
           (execute-sequence (cdr procs) env))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence - ANALYZE"))
    (lambda (env) (execute-sequence procs env))))
;;skip e4.24, happy Mid-Autumn Festival!