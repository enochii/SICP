;;e5.4

;a)
;(define (expt b n)
;  (if (= 0 n)
;      1
;      (* b (expt b (- n 1)))))
;;
(controller
 (assign continue (label expt-done))
 ;
 expt-loop
 (test (op =) (reg n) (const 0))
 (branch (label base-case))
 ;
 ;;no need to save n or b
 (assign n (op -) (reg n) (const 1))
 (restore continue)
 (assign continue (label after-that))
 (goto (label expt-done))
 ;
 after-that
 (assign product (op *) (reg product) (reg b))
 (restore continue)
 (goto continue)
 ;
 base-case
 (assign product (const 1))
 (goto continue)
 ;
 fact-done)

;b)
;(define (expt b n)
;  (define (expt-iter counter product)
;    (if (= counter 0)
;        product
;        (exp-iter (- count 1) (* b product))))
;  (expt-iter n 1))

(controller
 ;(assign continue (label expt-done))
 (assign product 1)
 ;
 expt-loop
 (test (op =) c (const 0))
 (branch (label fact-done))
 ;else
 (assign c (op -) (reg c) (const 1))
 (assign product (op *) (reg b) (reg product))
 (goto (label fact-loop))
 ;
 fact-done
 )