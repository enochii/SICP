(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (loop temp (cons (car x) y)))))
  (loop x '()))
(display (mystery '(1 2 3 4 (5 6))))
;;mystery reverse