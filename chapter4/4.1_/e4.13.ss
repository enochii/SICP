;;e4.13, here i just remove only the binding of the first frame of the environement
;;cause i think it should be just like define-variable-value, u should not change
;;the enclosing environment, in addition, it maybe easier hhh
;
;(load ".\\e4.12.ss")
;;at first i think i can use traverse-env defined in e4.12, but there seems to be
;;be different between them. if we want to remove a binding, we may need to record
;;the previous binding, and change its cdr. if the desired binding does not exist
;;we just simply signal an error.
(define (make-unbound! var env)
  (define (signal-error) (error "Unbound var -- MAKE-UNBOUND!" var))
  (define (scan vars vals)
    (cond ((null? (cdr vars)) (signal-error))
          ((eq? (cadr vars) var) 
           (set-cdr! vars (cddr vars))
           (set-cdr! vals (cddr vals)))
          (else (scan (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
      (error "Empty env -- MAKE-UNBOUND!" env)
      (let ((frame (first-frame env)))
        (if (null? frame)
            (signal-error)
            (cond ((eq? var (car (frame-variables frame)))
                   (set-car! frame (cdr (frame-variables frame)))
                   (set-cdr! frame (cdr (frame-values frame))))
                  (else
                   (scan (frame-variables frame)
                         (frame-values frame))))))))
;(load ".\\env-representation.ss")
(define (test-4.13)
  (define env (list (cons '(a s b c ) '(1 0 2 0)) (cons '(c d) '(3 4))))
  (make-unbound! 'a env)
  (display env)(newline)
  (make-unbound! 'c env)
  (display env)(newline)
  )
;(test-4.13)