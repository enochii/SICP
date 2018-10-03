;;skip a lot
;;solution of e4.51
(define (analyze-permanent-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (value fail2)
               (set-variable-value! var value env)
               (succeed 'ok fail2))
             fail))))
;
(define (permanent-assignment? exp)
  (tagged-list? exp 'permanent-set!))
;
(define e4.51
  '(define (e4.51)
     (define count 0)
     (let ((x (an-element-of '(a b c)))
           (y (an-element-of '(a b c))))
       (permanent-set! count (+ count 1))
       (require (not (eq? x y)))
       (list x y count))))
;;if use set!, value of count is always 1