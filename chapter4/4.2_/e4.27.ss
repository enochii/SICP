;;e4.27
(define count 0)
(define (id x)
  (set! cunt (+ count 1))
  x)

;;
(define w (id (id 10)))
;;L-Eval input:
;count
;;L-Eval value:
;1    ;;note here
;;L-Eval input:
;w
;;L-Eval value:
;10
;;L-Eval input:
;count
;;L-Eval value:
;2
;
;;at first, evaluator recieve an exp : (id (id 10))
;;then, cause id is a compound-procedure, so internal (id 10) won't be evaled
;;let's see the next step, control go to external id's body:
;        ((set! count (+ 1 count)) x)
;;evaluator will use eval-sequence to eval the above body, and count will do a
;;increment. when eval expression 'x, our evaluator will use lookup-variable to
;;search the current env, the env has been expanded by the binding (x -> (id 10))
;;and evaluator thinks that it has done all the supposed jobs, so in the env
;;the value of w is (id 10) finally.
;;and cause we send w to driver-loop, which will call actual-value, so (id 10)
;;will be evaled, and after that count transform 1 to 2.