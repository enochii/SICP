;(define (sqrt x) 'xixi)
(define (test x)
  (define (sqrt x)
    'xixi)
  (sqrt x))
;;first defination of sqrt isn't permitted, but second is.
;;cause global-sqrt has been defined
(test 10)