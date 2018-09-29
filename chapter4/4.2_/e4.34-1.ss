;;
(define (stream? exp)
  (tagged-list? (car exp) 'stream))
(define (print-stream exp env)
  (list
   (let ((first (actual-value (cdar exp) env)))
     (if (and (pair? first) (stream? first))
         (print-stream first env)
         first))
   '...))