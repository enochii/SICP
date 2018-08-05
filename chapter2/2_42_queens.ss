;;;queens
(load "d:\\sicp\\chapter2\\list_operation.ss")
(load "d:\\sicp\\chapter2\\flatmap.ss")
(define (rows n row)
  (map (lambda (x)
             (list (cons row x)))
           (enumerate-interval 1 n)))
;;test
;(display (rows 4 1))

(define (valid-position? lis)
  ;;filter-function
  (define (recur first rest)
    (if (null? rest)
        #t
        (let ((car-rest (car rest))
          ;(cdr-rest (cdr rest))
          )
      (if (or (= (car first) (car car-rest))
              (= (cdr first) (cdr car-rest))
              (= (- (car first) (car car-rest))
                 (- (cdr first) (cdr car-rest)))
              (= (- (car car-rest) (car first))
                 (- (cdr first) (cdr car-rest)))
              )
          #f
          (recur first (cdr rest))))))
  ;(if (null? (cdr lis))
     ; #t
      (recur (car lis) (cdr lis)))
      
(define (queens sides)
  (define (iter n)
    (if (= n 1)
      (rows sides 1)
      (filter valid-position?
              (flatmap (lambda (lis)
                 (map (lambda (x)
                        (cons x lis))
                      (map car (rows sides n))))
               (iter (- n 1))))))
  (iter sides)
      )
;;test
(length (queens 8));;92
  