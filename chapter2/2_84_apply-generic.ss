;;2.84
;;here just need to consider two argument
(load ".//2_83_raise.ss")

(define 'scheme-number 0)
(define 'rational 1)
(define 'real 2)
(define 'complex 3)
(define less <)
(define bigger >)
(define equal =)
;;
(define (super-raise x target-type)
  (if (equal (type-tag x) target-type)
      (cons #t x)
      ;;else if
      (let ((raise-proc (get 'raise (type-tag x))))
        (if raise-proc
            (super-raise (raise-proc x) target-type)
            (cons #f x)))))
            
(define (apply-generic op args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((a1 (car args))
                    (a2 (cadr args))
                    (t1 (car type-tags))
                    (t2 (cadr type-tags)))
                (cond ((equal t1 t2)
                       (error "no method for these types"
                              (list op type-tags)))
                      ((less t1 t2)
                       (let ((proc (get op (list t2 t2))))
                         (if proc
                             (let ((result (super-raise a1 t2)))
                               (if (car result)
                                   (proc (cdr result) a2)
                                   (error "no method ... lack of raise-proc"
                                          (list op type-tags))))
                             (error "no method even change args all to type"
                                    t2))))
                      ((less t2 t1)
                       (let ((proc (get op (list t1 t1))))
                         (if proc
                             (let ((result (super-raise a2 t1)))
                               (if (car result)
                                   (proc a1 (cdr result))
                                   (error "no method... lack of raise-proc"
                                          (list op type-tags))))
                             (error "no method even change args all to type"
                                    t1))))))
              (error "no method ... length of args is not 2"))))))