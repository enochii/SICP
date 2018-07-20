(load "d:\\sicp\\chapter1\\1_43.ss");repeated
(load "d:\\sicp\\chapter1\\average-damp.ss")
(load "d:\\sicp\\chapter1\\fixed-point.ss")
(load "d:\\sicp\\aux_\\math.ss")

(define (root-4 x)
  (fixed-point ((repeated average-damp 2) 
                (lambda (y) (/ x (cube y)))) 1.0))
(root-4 16.0)

(define (product n x)
  (if (= 0 n)
      1
      (if (even? n)
          (square (product (/ n 2) x))
          (* x (product (- n 1) x)))))
;;;(lg x)
(define (lg n)
  (cond ((> (/ n 2) 1)
         (+ 1 (lg (/ n 2))))
        ((< (/ n 2) 1)
        0)
        (else
         1)))

;;;root-n
(define (root-n n x)
  (fixed-point ((repeated average-damp
                          (lg n)
                          ;(quotient n 2)
                          )
                (lambda (y) (/ x (product (- n 1) y)))) 1.0))
(root-n 4 16.0);2.0000000000021965
(root-n 8 256);2.000000000003967
(root-n 5 243);3.0000008877496294



  
