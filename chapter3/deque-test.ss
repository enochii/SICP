(define (test-code)
  (define d (make-deque))
  (display (empty-deque? d))(newline)
  (print-deque (front-insert-deque! d 'foo));
  (print-deque (front-insert-deque! d 'xixi));
  (print-deque (rear-insert-deque! d 'schbsb))
  (print-deque (front-insert-deque! d 'xi));
  (print-deque (rear-insert-deque! d '0903))
  (print-deque (front-delete-deque! d))
  (print-deque (front-delete-deque! d))
  (print-deque (front-delete-deque! d))
  (print-deque (front-delete-deque! d))
  (print-deque (front-delete-deque! d))
  (print-deque (rear-insert-deque! d 'yyy))
  (print-deque (rear-insert-deque! d 'yyyy))
  (print-deque (rear-delete-deque! d));
  (print-deque (rear-delete-deque! d));
  (print-deque (front-insert-deque! d 'xixixi));
  ;(display (front-delete-deque! d))(newline);;empty deque
  'done)