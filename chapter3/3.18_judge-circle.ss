;;load "not-recored?" proc
(load "d:\\sicp\\chapter3\\3.17_count-pairs.ss")
(define x '(nz hz cc))
(set-cdr! (cddr x) x)
;(pair? '())
(define (circle? x)
  (define records '())
  (define (iter a)
    (cond ((not (pair? a)) #f)
          ((not-recorded? a records)
           (begin (set! records (cons a records))
                  (iter (cdr a))))
          (else #t)))
  (iter x))
(load "d:\\sicp\\chapter3\\3.19_judge-circle.ss")
(circle? '(1 2 (1 2)))
(circle? x)
(circle? '(1 1 1 1 1))
(circle? (append '(1 2) x))