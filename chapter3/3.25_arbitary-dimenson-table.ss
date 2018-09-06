(define (make-table) (list '*table*))
(define (lookup keys table)
  (cond ((null? keys) (car table))
        ((null? (cdr table)) #f);;this can be included in else-clause
        (else 
         (let ((subtable (assoc (car keys) (cdr table))))
           (if subtable
               (lookup (cdr keys) (cdr subtable))
               #f)))))
;
;;use the place-holder to gain the consistance of table structure
(define (place-holder) 'place-holeder)
(define (insert! keys value table)
  (cond ((null? keys) (set-car! table value))
        (else 
         (let ((subtable (assoc (car keys) (cdr table))))
           (if subtable
               (insert! (cdr keys) value (cdr subtable))
               (let ((new-item (list (car keys)
                                     (place-holder))))
                 (begin (set-cdr! table (cons new-item (cdr table)))
                        (insert! (cdr keys) value (cdr new-item)))))))))
(define _0 (make-table))
(insert! '(tj se) 200 _0)
(insert! '(tj se 'sch) 'sb _0)
(insert! '(tj) 'ilovetj _0)
(insert! '(fd fx wcc) 'nb _0)
(insert! '(fd fx) 'ky _0)

(lookup '() _0)
(lookup '(tj se) _0)
(lookup '(tj) _0)
(lookup '(tj se sch) _0)
(lookup '(fd) _0)
(lookup '(fd fx) _0)
(lookup '(fd fx wcc) _0)
(display _0)