;;shunting-yard algorithm->u may see it on: https://brilliant.org/wiki/shunting-yard-algorithm/
;;+ - * ^
(define (shunting-yard exp)
  (define (iter operators output exp)
    (if (null? exp)
        (if (null? operators)
            (car output);;
            (iter (cdr operators) (apply-op (car operators) output) exp))
        (let ((token (car exp)))
          (cond ((list? token)
                 (iter operators (cons (shunting-yard token) output) (cdr exp)))
                ((op? token)
                 (if (and (not (null? operators))
                       (or (and (eq? (associativity token) 'right)
                                (< (precedence token) (precedence (car operators))))
                           (and (eq? (associativity token) 'left)
                                (<= (precedence token) (precedence (car operators)))
                                )))
                  (iter ;(cons token (cdr operators))
                   (cdr operators)
                   (apply-op (car operators) output) ;(cdr exp)
                   exp;;push it to exp cause of difference of left and right ASSO, think about 2^3^4+1+2
                   )
                  (iter (cons token operators) output (cdr exp))))
                ((or (number? token) (variable? token))
                 (iter operators (cons token output) (cdr exp)))
                ))))
  (iter '() '() exp))
;;
(define (apply-op op output)
  (let ((lhs (cadr output))
        (rhs (car output)))
    (cons
     (cond [(eq? op '+) (make-sum lhs rhs)]
           [(eq? op '-) (make-difference lhs rhs)]
           [(eq? op '*) (make-product lhs rhs)]
           [(eq? op '^) (make-exponentiation lhs rhs)])
     (cddr output))))
(define (op? token)
  (or (eq? token '+) (eq? token '-) (eq? token '^) (eq? token '*)))
(define (associativity token)
  [cond [[or [eq? token '+] [eq? token '-] [eq? token '*]]
         'left]
        [[eq? token '^]
         'right]
        [else error "unknown ASSO-OP" token]])
(define (precedence op)
  [cond
    [[eq? op '+] 1]
    [[eq? op '-] 2]
    [[eq? op '*] 3]
    [[eq? op '^] 4]
    [else error "unknown PRE-OP" op]])
;;boring procedure
(define (make-sum l r)
  [cond [[=number? l 0] r]
        [[=number? r 0] l]
        [[and [number? l] [number? r]] [+ l r]]
        [else [list l '+ r]]])
;(define (make-difference l r)
;  (make-sum l (- r)))
(define (make-product l r)
  (cond
    ((or (=number? l 0) (=number? r 0)) 0)
    ((=number? l 1) r)
    ((=number? r 1) l)
    ((and (number? l) (number? r)) (* l r))
    (else (list l '* r))))
(define (make-exponentiation l r)
  (cond
    ((=number? r 0) 1)
    ((=number? l 0) 0)
    ((=number? r 1) l)
    (else (list l '^ r))))
;;
(define (=number? token num)
  (and (number? token) (= num token)))
(define (variable? x)
  (symbol? x))
;;test
(display (shunting-yard '(x * 3 + 2 ^ y ^ 3 * z * x)))