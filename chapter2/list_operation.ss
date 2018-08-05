(define (filter_ predicate sequence)
  (cond ((null? sequence) ())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter_ predicate (cdr sequence))))
        (else (filter_ predicate (cdr sequence)))))
;;;
;(display (filter_ odd? (list 1 2 3 4 5)))
;;;
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
;;
;(newline)
;(accumulate + 0 (list 1 2 3 4 5))
;(accumulate * 1 (list 1 2 3 4 5))
;;
(define (enumerate-tree tree)
  (cond ((null? tree) ())
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
;(display (enumerate-tree (list 1 (list 2 (list 3 4)) 5)))
;;
(load "d:\\sicp\\aux_\\math.ss")
(define (sum-odd-squares tree)
  (accumulate +
              0
              (map square
                   (filter_ odd?
                            (enumerate-tree tree)))))
(define (enumerate-interval low high)
  (if (> low high)
      (list)
      (cons low (enumerate-interval (+ 1 low) high))))
;(display (enumerate-interval 1 9))

(define (list-fib-squares n)
  (accumulate cons
              ()
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))
;;
(define (fib n)
  (define (iter i now next)
    (if (= i 0)
        now
        (iter (- i 1) next
              (+ now next))))
  (iter n 0 1))
;;
;(display (list-fib-squares 10))