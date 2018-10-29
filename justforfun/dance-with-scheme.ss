(define (transpose matrix)
  (apply map (cons list matrix)))
;
(transpose '((1 2 3)
             (4 5 6)
             (7 8 9)))
;
(define (flat-map f xs)
  (apply append (map f xs)))
;
(define-syntax list-of
  (syntax-rules (<-)
    ((_ expr (v <- aList) rule ...)
     (flat-map (lambda (v) (list-of expr rule ...)) aList))
    ((_ expr filter rule ...)
     (if filter (list-of expr rule ...) '()))
    ((_ expr) (cons expr '()))))
;
(list-of (list x y) (x <- '(1 2)) (y <- '(a b)))