(define (update-polynomial-package)
  ;;we can still use the internal procedures in polynomial-package before
  (define (sub-poly p1 p2)
    (add-poly p1 (negtive-poly p2)))
  (define (negtive-poly p)
    (define (iter-negtive-termlist l)
      (if (empty-termlist? l)
          l
          (let ((t (first-term l)))
            (adjoin-term (make-term (order t) (negtive (coeff t)))
                         (negtive-poly (rest-terms l))))))
    (make-poly (variable l) (iter-negative-termlist (term-list p))))
  (put 'negative '(polynomial) negativ-poly)
  (put 'sub '(polynomial) (tag 'polynomial 
                               (lambda (x y) (sub-poly x y))))
  'done)
;;we may need to define negative procedures for scheme-number, complex ...