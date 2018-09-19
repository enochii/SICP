(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        ;(display first)
        (if (cond-else-clause? first)
            (begin (display "COND-ELSE")
                   (if (null? rest)
                       (sequence->exp (cond-actions first))
                       (error "ELSE clause isn't last -- COND->IF" clauses)))
            (let ((acts (cond-actions first)))
              (make-if (cond-predicate first)
                       (make-if 
                        (eq? '=> (car acts))
                        (make-if (null? (cddr acts))
                                 ;;------combinating way maybe wrong.
                                 ((cadr acts) (cond-predicate first))
                                 (error "=> -- EXPAND-CLAUSES"))
                        (sequence->exp acts))
                       (expand-clauses rest)))))))

;;

;(define 'cadr cadr)
;;cond->if test
(define (test-cond->if);;don't support =>
  (load ".//4.1.2.ss")
  ;;expand-clauses is the version in 4.1.2.ss
  (expand-clauses '((#f aaaaaa)
                    ((assoc c ((a 1) (b 2))) '=> cadr)
                    (else haha)
                    )))
;(test-cond->if)