(define (make-sum x y)
  ;(list '+ x y));;v1
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        ((and (number? x) (number? y)) (+ x y))
        (else (list '+ x y))))
;;sum
(define (sum? l)
  (and (pair? l) (eq? '+ (car l))))
(define (addend s) (cadr s))
(define (augend s) (caddr s))