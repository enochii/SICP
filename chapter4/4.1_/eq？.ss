;;support eq?, it seems that i have to define it by myself
(define (eq?? exp)
  (tagged-list? exp 'eq?))
(define (eval-eq? exp env)
  (let ((x (eval_ (cadr exp) env))
        (y (eval_ (caddr exp) env)))
    (if (eq? x y) 'true 'false)))