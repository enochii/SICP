(load "d:\\sicp\\chapter2\\hfm-tree.ss")
(define (fre n)
  (expt 2 (- n 1)))
;(fre 2)
(define (elts n)
  (define (iter i)
    (if (= i (+ 1 n))
        '()
        (cons (list 'leaf 'xi (fre i))
              (iter (+ 1 i)))))
  (iter 1))
;(display (elts 3))
(define (t n) (cadr (hfm (elts n))))

(print-code (t 5));1 4
(newline)
(print-code (t 10));1 9
(newline)
(print-code (t 12))
;1 n - 1
