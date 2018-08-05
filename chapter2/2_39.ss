;;2.38
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest)) (cdr rest))))
  (iter initial sequence))
;;
(define 1-3 (list 1 2 3))
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))
;;
(fold-right / 1 1-3);3/2
(fold-left / 1 1-3);
;(display (fold-right list () 1-3))
;(display (fold-left list () 1-3))
;;;满足交换律

;;2.39
(define (reverse_ sequence)
  (fold-right (lambda (x y)
                (append y (list x)))
              () sequence))
(display (reverse_ 1-3))
(define (reverse__ sequence)
  (fold-left (lambda (x y)
               (cons y x))
             () sequence))
(display (reverse__ 1-3))