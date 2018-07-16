;;;1.30
(define (self x) x)
(define (inc x) (+ 1 x))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))
      ))
;;;iter-fact
(define (iter-product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

;;;factorial
(define (factorial a)
  (iter-product self 1 inc a))
;;;圆周率
;;;通项公式 (/ (+ 1 k) (+ 2 k)),if:(= (remainder k 2) 1)
;;;       (/ (+ 2 k) (+ k 1)),else
(define (pi-term k)
  (if (= (remainder k 2) 0)
      (/ (+ 2 k) (+ k 1))
      (/ (+ 1 k) (+ 2 k))
      ))
;;;calculate
(define (quater-pi n)
  (iter-product pi-term 1.0 inc n))
(define (pi n)
  (* 4.0 (quater-pi n)))


