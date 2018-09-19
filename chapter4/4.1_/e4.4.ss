(define (eval exp env)
  (cond ;;.......
    ((and? exp) (eval-and exp env))
    ((or? exp) (eval-or exp env))
    ;;........
    ))


;(and e1 e2 e3 ...)
(define (eval-and exp env)
  (define (helper ops)
    (let ((first (eval (car ops) env)))
      (if first
          (if (null? (cdr ops));;last one
              first
              (helper (cdr ops)))
          'false)))
  (let ((ops (cdr exp)))
    (if (null? ops)
        'true
        (helper ops))))
;;(or e1 e2 e3 ...)
(define (eval-or exp env)
  (define (helper ops)
    (cond ((null? ops) 'true)
          ((eval (car ops) env)
           'true)
          (else
           (helper (cdr ops)))))
  (let ((ops (cdr exp)))
    (if (null? ops)
        'false
        (helper ops))))

;;-------------------------------------------------------------------
;;derived from if ...
;;;;;and
(define (and->if exp)
  (let ((exps (cdr exp)))
    (if (null? exps)
        'true
        (expand-exps-and exps))))
(define (expand-exps-and exps)
  (if (null? (cdr exps));;last one
      ;(make-if (car exps) (car exps) 'false)
      (car exps)
      (make-if (car exps) (expand-exps-and (cdr exps)) 'false)))
;;;;;;or
(define (or->if exp)
  (let ((exps (cdr exp)))
    (expand-exps-or exps)))
(define (expand-exps-or exps)
  (if (null? exps)
      'false
      (make-if (car exps)
               'true
               (expand-exps-or (cdr exps)))))
;;
(define (eval exp env)
  (cond ;;.......
    ((and? exp) (eval (and->if exp) env))
    ((or? exp) (eval (or->if exp) env))
    ;;........
    ))