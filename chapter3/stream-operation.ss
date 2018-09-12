(define (infinite-play x) 
  (infinite-play 
   (infinite-play x))
  )
;(infinite-play 'xixi)

(define (cons-stream a b)
  (display "im here")
  (cons a (delay b)))
;(cons-stream 'a (display "pny"))
;;'pny is displayed before 'im here, when we do (cons-stream a b) as a procedure
;;call, expression b will be evaluated before application of cons-stream
;;i learn it from :https://github.com/ivanjovanovic/sicp/blob/master/3.5/3.5.scm

(define-syntax cons-stream
  ;(cons a (delay b)))
  (syntax-rules ()
    ((cons-stream x y)
     (cons x (delay y)))))
;(cons-stream 1 (infinite-play '+))
;;
(define (stream-car xi) (car xi))
(define (stream-cdr xi) (force (cdr xi)))
;;others basic operation
(define (stream-ref s n);
  (if (<= n 0);;assume that n is positive
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s));;if we reverse order of clauses inside 'begin
             (stream-for-each proc (stream-cdr s)))))
(define (display-stream s)
         (stream-for-each display-line s))
(define (display-line x)
  (display x)(newline))
;;
(define (stream-null? s) (null? s))
(define the-empty-stream '())
;;
;(display (stream-null?
;          (stream-cdr (cons-stream 1 the-empty-stream)))
;         )
(define (stream-filter pred stream)
  (cond ((stream-null? stream)
         the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred (stream-cdr stream))))
        (else
         (stream-filter pred (stream-cdr stream)))))
;;list
;;just like transfer list to stream, this proc is mainly for construct stream
;;for test
(define (stream . args)
  ;(display args)
  (if (null? args)
      the-empty-stream
      (cons-stream (car args) (apply stream (cdr args)))));;remember to use 'apply
;;;;;;;;;;;;;;;;;;;;;;;;;or the second call to stream is like (stream ((cdr args))
;;that's to say, the '.' will put a bracket to args