;;easy-apply-generic
(define (apply-generic op . args)
  ((get op (map type-tag args)) (map contents args)))
(define (type-tag number) (car number))
(define (contents number) (cdr number))
(define (attach-tag tag x) (cons tag x))