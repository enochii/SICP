(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))
;;;inc
(define (inc a)
  (+ 1 a))
(define (self a)
  a)
(define (sum-int a b)
  (sum self a inc b))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ (/ dx 2) a) add-dx b) dx))
;;;cube
(define (cube x) (* x x x))