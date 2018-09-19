;;this is a part of 4.1.3, remove it from 4.1.3 for the reason that we may 
;;replace it with other representation of environment
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())
;;a frame is represented as a pair of lists: a list of the variables bound in 
;;that frame and a list of the associated values
(define (make-frame vars values)
  (cons vars values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))
;;to extend an env by a new frame that associates variables with values, we make
;;a frame consisting of the list of variables and the list of values, and we 
;;adjoin it to the env. we signal an error if the number of vars does not match
;;the number of values
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))
;to look up a var in an env, we scan the list of vars in the first frame. if we
;find the desired var, we return the corresponding element in the list of values.
;if we don't find the var in the current frame, we search the enclosing env, and
;so on. if we reach the empty env, we signal an "unbound var" error
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (if (null? vars)
          (env-loop (enclosing-environment env))
          (if (eq? (car vars) var)
              (car vals)
              (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))
;;set a variable to a new value
(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars) (env-loop (enclosing-environment env)))
            ((eq? (car vars) var) (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))
;;here i think it may be better if we make a common definition for 
;;lookup-variable-value and set-variable-value!
;;
;;to define a var, we search the first frame for a binding for the var, and
;;change the binding if it exists, if no such binding exists, we adjoin one to 
;;the first frame
(define (define-variable! var val env)
  (let ((frame (first-frame env)));;here i think we should judge if the env is
    (define (scan vars vals);;empty
      (cond ((null? vars) 
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else
             (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))
;(extend-environment '(a) '(1) the-empty-environment)