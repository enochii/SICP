(load "d:\\sicp\\chapter3\\table-1.ss")
(define (memoize f)
  (let ((table (make-table)))
    (lambda (n)
      (let ((prev-computed-result (lookup n table)))
        (or prev-computed-result
            (let ((result (f n)))
              (insert! n result table)
              result))))))
(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))
;;
(memo-fib 5)