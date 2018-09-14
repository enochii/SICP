(load "d:\\sicp\\chapter3\\3.5.4.ss")
(define (yyy-RLC r l c dt)
  (define (rlc-return v0 i0)
    (define i 'fake-i)
    (define dv 'fake-dv)
    (define di 'fake-di)
    
    (define v (integral (delay dv)
                        v0 dt))
    (set! i (integral (delay di)
                      i0 dt))
    (set! dv (scale-stream i (/ -1 c)))
    (set! di (add-streams (scale-stream v (/ 1 l))
                          (scale-stream i (/ (- r) l))))
    
    (cons v i))
  rlc-return)

(define (RLC r l c dt)
  (define (rlc-return v0 i0)
    (define i 'fake-i)
    ;(define dv 'fake-dv)
    ;(define di 'fake-di)
    
    (define v (integral (delay (scale-stream i (/ -1 c)))
                        v0 dt))
    (set! i (integral (delay (add-streams (scale-stream v (/ 1 l))
                                          (scale-stream i (/ (- r) l))))
                      i0 dt))
    ;(set! dv (scale-stream i (/ -1 c)))
    ;(set! di (add-streams (scale-stream v (/ 1 l))
    ;                      (scale-stream i (/ (- r) l))))
    
    (cons v i))
  rlc-return)
;;
(define RLC1 ((RLC 1 1 0.2 0.1) 10 0))
(define v (car RLC1))
(define i (cdr RLC1))
(stream-ref v 100)
(stream-ref i 100)

;(define a (cons-stream 0 'ciiiiiiii))
;a