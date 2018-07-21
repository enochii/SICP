;some math function

(define (square a)
  (* a a)
  )

(define (cube x)
  (* x x x))

(define (divides? a b)
  (= 0 (remainder a b)))

;;;average
(define (average a b)
  (/ (+ a b) 2))

(define (inc x)
  (+ x 1))

(define (mygcd a b)
  (define (iter a b);;;assume that a > b
    (if (= 0 (remainder a b))
        b
        (iter b (mod a b))))
  (if (< a b)
      (gcd b a)
      (gcd a b)))