;;load accumulate
(load "d:\\sicp\\chapter2\\list_operation.ss")
;;vec * vec
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
;;test
;(display (dot-product (list 1 2 3) (list 3 4 5)));26
;;mat * vec
(define (matrix-*-vector m v)
  ;;return a vector
  (map (lambda (x)
         (dot-product x v))
       m))
;;test
(load "d:\\sicp\\chapter2\\2_32_subsets.ss")
(define mat (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define vec (list 1 2 3 4))
;(display (matrix-*-vector mat vec))

;;transpose
(define (transpose m)
  (define (car-n m)
    (map car m))
  (define (cdr-n m)
    (map cdr m))
  (if (null? (car m))
      ()
      (cons (car-n m)
            (transpose (cdr-n m)))))
;;test trans
;(print-subsets (transpose mat))
;;easy-transpose
(load "d:\\sicp\\chapter2\\2_36_accumulate-n.ss")
(define (transpose-1 mat)
  (accumulate-n cons () mat))
;;
;(print-subsets (transpose-1 mat))

;;mat * mat
;(define (matrix-*-matrix m n)
(define (matrix-*-matrix m n)
  (let ((trans-n (transpose n)))
    (map (lambda (x)
           (matrix-*-vector trans-n x))
         m)))
(define t (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(print-subsets (matrix-*-matrix t t))