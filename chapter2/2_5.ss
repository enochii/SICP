;;;2.5
(define (cons_ a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car_ z)
  (if (= 0 (remainder z 2))
      (+ 1 (car_ (/ z 2)))
      0))
;;;cdr
(define (cdr_ z)
  (if (= 0 (remainder z 3))
      (+ 1 (cdr_ (/ z 3)))
      0))
(define t (cons_ 3 5))
(display (car_ t))
(newline)
(display (cdr_ t))
