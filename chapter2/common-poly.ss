;;internal interfaces
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))
(define (empty-termlist? term-list) (null? term-list))
(define (the-empty-termlist) '())
;(define (adjoin-term term terms) (cons term terms))
(define (rest-terms term-list) (cdr term-list))
(define (same-variable? x y)
  (and (symbol? x) (symbol? y) (eq? x y)))
(define (variable x) (car x))
(define (term-list x) (cdr x))

;;may need to define generic procedure
(define make-negative -);;
(define add +)
(define mul *)
(define div /)
(define =zero? (lambda (x) (= 0 x)))