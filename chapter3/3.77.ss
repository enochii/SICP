(define (integral integrand initial-value dt)
  (cons-stream
   initial-value
   (if (stream-null? integrand)
       the-empty-stream
       (integral (stream-cdr integrand)
                 (+ (* dt (stream-car integrand)) initial-value)
                 dt))))
;;
(define (integral-delay delayed-integrand initial-value dt)
  (cons-stream
   initial-value
   (let ((integrand (force delayed-integrand)))
     (if (stream-null? integrand)
         the-empty-stream
         (integral-delay (delay (stream-cdr integrand))
                         (+ (* dt (stream-car integrand)) initial-value)
                         dt)))))