;;e4.14 use the primitive map, take car as example, the structure of 
;;map-exprssion is like this :
;;'(map car (list (cons 1 2) (cons 2 3)))
;;car will be evaluated as (primitive #<procedure:mcar>)
;;and then our evaluator will do such action:
;;(apply map (primitive #<procedure:mcar>) ((1 . 2) (2 . 3)))
;;but scheme-underlying-system doesn't know what (primitive #<procedure:mcar>) is.
;;
;;and here i want to support map with just one sequence
;;here use scheme underlying map, or u can replace it with iteration
(define (map? exp)
  (tagged-list? exp 'map))
;;(map proc seq)
(define (map-procedure exp) (cadr exp))
(define (map-sequence exp) (caddr exp))
(define (eval-map exp env)
  (let ((seq (eval_ (map-sequence exp) env))
        (proc-name (map-procedure exp)))
    (display seq);
    ;(map (lambda (x) (eval_ (list proc-name x) env)) seq)))
    (let ((proc (eval_ proc-name env)))
      (if (primitive-procedure? proc)
          (map (primitive-implementation proc) seq)
          ;;compound-procedure isn't supported
          ;;self-defined proc left
          (map (lambda (x) (eval_ (list proc-name x) env)) seq)))))
;;emmm, and i found i'm too foolish, self-defined proc will become a 
;;compound-procedure...
;;maybe with good abstraction, we can reuse the apply_
;;maybe i'm not so foolish, if use apply_, we need to distinguish the type
;;of object, u may find that with self-calculating object, it works perfectly,
;;but not so with pair or list, that's because our evaluator doesn't regard 
;;them the same as number or string.