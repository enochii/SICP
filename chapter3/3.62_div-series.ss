(load "d:\\sicp\\chapter3\\3.61_1-div-s.ss")
(load "d:\\sicp\\chapter3\\3.59_integrate-series.ss")
(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
      (error "car of denom-stream is zero!")
      (mul-series s1 (1/s s2))))
;;
(infinite-stream-test (div-series ints only-one-one))
(define tan-series
  (div-series sine-series cosine-series))
(infinite-stream-test tan-series)