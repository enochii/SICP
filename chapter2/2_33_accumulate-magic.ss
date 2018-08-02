;;2.33
(load "d:\\sicp\\chapter2\\list_operation.ss")
(define (map_ p sequence)
  (accumulate (lambda (x y)
                (cons (p x) y))
              ()
              sequence))
;;
(load "d:\\sicp\\aux_\\math.ss")
;(display (map_ square (list 1 2 3 4)))
;;
(define (append_ seq1 seq2)
  (accumulate cons
              seq2
              seq1))
;;test append
;(newline)
;(display (append (list 1 2 3 4) (list 2 4 (list 2 3))))
;;
(define (length_ sequence)
  (accumulate (lambda (x y) (+ 1 y))
              0
              sequence))
;;test length
(define x (list 1 3 4 3 (list 2 3)))
(length_ x)
(length x)