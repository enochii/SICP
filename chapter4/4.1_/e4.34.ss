;;i think it's a extension of 4.2.3
;;i may use some value in the head of a stream to simply represent it when eval it
;;
(define (stream? exp)
  (tagged-list? exp 'stream))
(define (stream-lambda exp)
  (cdr exp))
(define (eval-stream exp env)
  ;(if (null? exp)
      ;'()
  (display (list
            (eval_ (list 'car exp) env)
            '...
            <#lazy-stream>)))