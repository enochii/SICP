;;
(load "d:\\sicp\\chapter2\\list_operation.ss")
(define x (accumulate append
            ()
            (map (lambda (i)
                   (map (lambda (j)
                         (list i j))
                         (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 10))))
;(display x)
;;flatmap
(define (flatmap proc seq)
  (accumulate append () (map proc seq)))
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
;;
(load "d:\\sicp\\chapter1\\prime.ss")
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
;;
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap (lambda (i)
                          (map (lambda (j)
                                 (list i j))
                               (enumerate-interval 1 (- i 1))))
                        (enumerate-interval 1 n)))))
;;
(define x (prime-sum-pairs 10))
;(display x)
;(remove 1 (list 1 2 3))
(define (permutations s)
  (if (null? s)
      (list ())
      (flatmap (lambda (x)
                 (map (lambda (y)
                        (cons x y)) (permutations (remove x s))
                       ))
               s)))
;;test
;(display (permutations (list 1 2 3)))