;;;load
(load "D:\\sicp\\chapter1\\general-sum.ss")

(define (sps-integral f a b n)
  (let ((h (/ (- a b) n)))
    ;;;term
  (define (sps-term k)
    (let ((yk (f (+ a (* k h)))))
    (cond ((or (= 0 k) (= n k)) yk)
          ((= (remainder k 2) 0) (* 2 yk))
          (else (* 4 yk)))))
    (* (/ h 3) (sum sps-term 0 inc n))))