;;non-sorted
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? (car set) x) #t)
        (else (element-of-set? x (cdr set)))))
;;
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))
;;
(define (intersection-set s1 s2)
  (define (iter result s1 s2)
    (if (or (null? s1) (null? s2))
        result
        (let ((new (car s1))
              (rest (cdr s1)))
          (if (element-of-set? new s2)
              (iter (cons new result) rest s2)
              (iter result rest s2)))))
  (iter '() s1 s2))
;;test
(display (intersection-set '(1 2 3) '(1 5 6 2 7)))
;;
(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else
         (let ((v1 (car s1))
               (r1 (cdr s1))) 
           (if (element-of-set? v1 s2)
               (union-set r1 s2)
               (cons v1 (union-set r1 s2))))
         )))
;;
(newline)
(display (union-set '(1 2 3) '(1 5 6 2 7)))