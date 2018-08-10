;;sorted-set
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= (car set) x) #t)
        ((> (car set) x) #f)
        (else (element-of-set? x (cdr set)))))
;;
(define (intersection-set s1 s2)
  (if (or (null? s1) (null? s2))
      '()
      (let ((car-s1 (car s1))
            (car-s2 (car s2)))
        (cond ((= car-s1 car-s2)
               (cons car-s1 (intersection-set (cdr s1) (cdr s2))))
              ((< car-s1 car-s2)
               (intersection-set (cdr s1) s2))
              (else
               (intersection-set s1 (cdr s2)))))))
;;test
;(display (intersection-set '(1 2 3 4 5) '(1 3 5 7)))
;;
(define (adjoin-set x set)
  (define (iter prev rest)
    (cond ((or (null? rest)
            (> (car rest) x))
           (append prev (cons x rest)))
          ((= (car rest) x)
           set)
          (else
           (iter (append prev (list (car rest))) (cdr rest)))))
  (iter '() set))
;;
(display (adjoin-set 4 '(1 2 3 5)))
(newline)
(display (adjoin-set 4 '(1 2 3 4 5)))
;;union
(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((v1 (car s1))
                    (v2 (car s2)))
                (cond ((= v1 v2) (union-set (cdr s1) s2))
                      ((< v1 v2) (cons v1 (union-set (cdr s1) s2)))
                      (else (cons v2 (union-set s1 (cdr s2)))))))))
;;
(newline)
(display (union-set '(1 3 5) '(1 2 4 8)))
