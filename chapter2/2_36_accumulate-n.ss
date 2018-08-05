;;;2.36
(define (accumulate-n op init seqs)
  (define (helper seq1 seq2)
    (if (null? seq1)
        ()
        (cons (op (car seq1) (car seq2))
              (helper (cdr seq1) (cdr seq2)))))
  (if (null? (cdr seqs))
      (car seqs)
      (helper (car seqs) (accumulate-n op init (cdr seqs)))))
;;
(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
;(display(accumulate-n + 0 s))
;;;
(define (car-n l)
  (map car l))
;(display (car-n s))
(define (cdr-n l)
  (map cdr l))
;;
(define (accumulate-n-1 op init seqs)
  (if (null? (car seqs))
      ()
      (cons (accumulate op init (car-n seqs))
            (accumulate-n op init (cdr-n seqs)))))
;;
(load "d:\\sicp\\chapter2\\list_operation.ss")
;;
(display (accumulate-n-1 cons () (cdr-n s)))
;(display s)
(newline)
(display (cdr-n s))