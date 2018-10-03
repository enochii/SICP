;;e4.53
;;'(23 111 36 21)
(define e4.53
  '(define (e4.53)
     (let ((pairs '()))
       (if-fail 
        (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
          (permanent-set! pairs (cons p pairs))
          ;(display pairs)
          (amb))
        pairs)
       )))
(load "d:\\sicp\\chapter4\\4.3\\prime.ss")
;
(pre-process prime?)
;
(pre-process e4.53)