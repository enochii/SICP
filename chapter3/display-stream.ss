(define (iter cur s)
      (cond ((= 0 cur)
             'done)
            (else
             (begin (display (stream-car s))(newline)
                    (iter (- cur 1) (stream-cdr s))))))

(define (display-stream stream . num)
  (let ((count 10));;default
    (if (not (null? num))
        (set! count (car num)))
        (iter count stream)))