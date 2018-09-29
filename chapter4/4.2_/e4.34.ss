;;i think it's a extension of 4.2.3
;;i may use some value in the head of a stream to simply represent it when eval it
;;
(define (stream? exp)
  (tagged-list? exp 'stream))

(define (print-stream exp env)
  ;(display (car exp))
  ;(display " ")
  ;(display (cdr exp))
  (list
   (let ((first (actual-value (list 'car exp) tgv)))
     (if (stream? first)
         (print-stream first env)
         first))
   '...)
  )
;;BECARE: if we use memoization and eval-stream above concurrently, the represenation
;;of what we define will become the new value of the binded name in env

;;... this is a long time struggling with it, cons-exp -> stream-exp, after that we
;;can't eval it anymore unless we make a rule stream-exp -> stream-exp