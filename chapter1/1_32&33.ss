;;;1_32
(load "D:\\sicp\\chapter1\\general-sum.ss")
(load "D:\\sicp\\chapter1\\prime.ss")
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (+ (term a) (accumulate combiner null-value term (next a) next b))
      ))
;;;1_33
(define (iter-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (cond ((> a b) result)
          ((filter a) (iter (next a) (+ (term a) result)))
          (else (iter (next a) result))
        ))
  (iter a null-value))
  
;;;null-value=1
(define (sum-prime2n n)
  (define (filt x)
    (not (= (remainder n x) 0)))
  (iter-accumulate filt + 1 self 1 inc (- n 1)))

(define (sum-prime a b)
  (iter-accumulate prime? + 0 self a inc b))
;;;
