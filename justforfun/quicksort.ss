;
(load "d:\\sicp\\aux_\\filter.ss")
;;split seq into 3 parts
(define (split seq)
  (let ((first-item (car seq)))
    (define (split-iter s)
      (if (null? s)
          (list '() '() '())
          (let ((cdr-result (split-iter (cdr s)))
                (cur-item (car s)))
            ;(display cdr-result)
            (cond ((> cur-item first-item)
                   (set-car! (cddr cdr-result)
                             (cons cur-item (caddr cdr-result))))
                  ((= cur-item first-item)
                   (set-car! (cdr cdr-result)
                             (cons cur-item (cadr cdr-result))))
                  (else;;<
                   (set-car! cdr-result
                             (cons cur-item (car cdr-result)))))
            cdr-result)
          ))
    (split-iter seq)))
;
(define (not-so-quicksort seq)
  (cond ((null? seq) seq)
        (else (append
               (not-so-quicksort (filter (lambda (x) (< x (car seq))) seq))
               (filter (lambda (x) (= x (car seq))) seq)
               (not-so-quicksort (filter (lambda (x) (> x (car seq))) seq))))))
;
(define (quicksort seq)
  (if (or (null? seq) (null? (cdr seq)))
      seq
      (let ((split-res (split seq)))
        (append (quicksort (car split-res))
                (cadr split-res)
                (quicksort (caddr split-res))))))
;test
(quicksort '(3 10 9 4 6 3 2 3 1))
;(1 2 3 3 3 4 6 9 10)
(not-so-quicksort '(3 10 9 4 6 3 2 3 1))
;(1 2 3 3 3 4 6 9 10)