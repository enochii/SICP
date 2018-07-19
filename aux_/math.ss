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