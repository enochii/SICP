;;skip e4.10, maybe the work is too large
;;e4.11, represent a frame as a list of bindings, where each binding is a named-value
;;pair.
;
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define (first-pair frame) (car frame))
(define the-empty-environment '())
;
(define (make-frame vars vals)
  (map (lambda (x y) (cons x y)) vars vals))
;
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))
;lookup-or-setvar-helper, this is a common implementation
(define (lookup-or-setvar-helper var
                                 val;;for setvar not for lookup
                                 env
                                 type;;type-tag of setvar or lookup
                                 )
  (define (env-loop env)
    (define (scan var-val-pairs);;frame is represented as a list of pairs
      (cond ((null? var-val-pairs) (env-loop (enclosing-environment env)))
            ((eq? (car (first-pair var-val-pairs)) var)
             (cond ((eq? type 'lookup-variable-value)
                    (cdr (first-pair var-val-pairs)))
                   ((eq? type 'set-variable-value!)
                    (set-cdr! (first-pair var-val-pairs) val))
                   (else
                    ("Unknown operation type -- SCAN" type))))
            (else (scan (cdr var-val-pairs)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- ENV-LOOP" var)
        (let ((frame (first-frame env)))
          (scan frame))))
  (env-loop env))
(define (lookup-variable-value var env)
  (lookup-or-setvar-helper var 'null-val env 'lookup-variable-value))
(define (set-variable-value! var val env)
  (lookup-or-setvar-helper var val env 'set-variable-value!))
(define (define-variable-value! var val env)
  (define (scan var-val-pairs)
    (cond ((null? var-val-pairs)
           (set-car! env (cons (cons var val) (first-frame env))))
          ((eq? var (car (first-pair var-val-pairs)))
           (set-cdr! (first-pair var-val-pairs) val))
          (else (scan (cdr var-val-pairs)))))
  (let ((frame (first-frame env)))
    (scan frame)))
;;
(define (test-4.11)
  (define env (list (list (cons 'a 1) (cons 'b 2)) (list (cons 'c 3) (cons 'd 4))))
  (display (extend-environment '(h) '(10) env))(newline)
  (display (lookup-variable-value 'a env))(newline)
  (display (lookup-variable-value 'c env))(newline)
  (set-variable-value! 'c 10 env)
  (display env)(newline)
  (set-variable-value! 'a 10 env)
  (display env)(newline)
  (define-variable-value! 'ri 1 env)
  (display env)(newline)
  )
;(test-4.11)