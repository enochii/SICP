;;thunk-representation with memoization
;;our evaluator must arrange to create thunks when procedures are applied to
;;args and to force these thunks later
;;a thunk must package an expression with the environment, so that the arg can be
;;produced later

;;create a thunk by list
(define (delay-it exp env)
  (list 'thunk exp env))
(define (thunk? obj)
  (tagged-list? obj 'thunk))
(define (thunk-exp thunk) (cadr thunk))
(define (thunk-env thunk) (caddr thunk))
;;actually, what we want is not quite this, but rather thunks that have been memoized
(define (evaluated-thunk? obj)
  (tagged-list? obj 'evaluated-thunk))
(define (thunk-value evaluated-thunk)
  (cadr evaluated-thunk))
(define (force-it obj)
  (cond ((thunk? obj)
         (let ((value (actual-value (thunk-exp obj) (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-cdr! obj (list value));;transform exp to val and remove env
           value;;return it at last
           ))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))