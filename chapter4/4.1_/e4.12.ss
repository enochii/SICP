;;e4.12 maybe have been done in e4.11, but i just make a common interface for lookup and set
;;do not want to write it again.
;;
;;zhenxiang
;;e4.12 here using the representation of book version
;(load ".\\env-representation.ss")
(define (traverse-env var val found-proc empty-frame-proc empty-env-proc env)
  (define (scan vars vals)
    (cond ((null? vars) (empty-frame-proc env))
          ((eq? var (car vars)) (found-proc vals))
          (else (scan (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
      (empty-env-proc var);;signal an error or ignore
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
;;it binding for var already exists, define! just works like set!
(define (define-variable! var val env)
  (define (found-proc vals) (set-car! vals val))
  (define (empty-frame-proc env) (add-binding-to-frame! var val (first-frame env)))
  (define (empty-env-proc var) 'ignore)
  (traverse-env var val found-proc empty-frame-proc empty-env-proc env))
(define (set-or-lookup var val env found-proc)
  ;(define (found-proc vals) (set-car! vals val))
  (define (empty-frame-proc en)
    (traverse-env var val found-proc empty-frame-proc empty-env-proc
                  (enclosing-environment env)))
  (define (empty-env-proc var) (error "Unbound variable -- SET-VARIABLE-VALUE" var))
  (traverse-env var val found-proc empty-frame-proc empty-env-proc env))
(define (set-variable-value! var val env)
  (define (found-proc vals) (set-car! vals val))
  (set-or-lookup var val env found-proc))
(define (lookup-variable-value var env)
  (define (found-proc vals) (car vals));;just return the the associated value
  (set-or-lookup var 'null-val env found-proc))
;;
(define (test-4.12)
  (define env (list (cons '(a b) '(1 2)) (cons '(c d) '(3 4))))
  (define-variable! 'e 5 env)
  (display env)(newline)
  (set-variable-value! 'c 33 env)
  (display env)(newline)
  (display (lookup-variable-value 'd env))(newline)
  )
;(test-4.12)