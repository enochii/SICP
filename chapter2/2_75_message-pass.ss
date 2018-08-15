;;book code
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? 'real-part op)
           x)
          ((eq? 'imag-part op)
           y)
          ;;......
          ))
  dispatch)
;;;;;;
;;2.75
;;;;;;
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'magnitude)
           r)
          ((eq? op 'angle)
           a)
          ((eq? op 'real-part)
           (* r (cos a)))
          ((eq? op 'imag-part)
           (* r (sin a)))
          (else "Unknown op" op)))
  dispatch)
;;
(define (apply-generic op z)
  (z op))
(define (real-part_ z)
  (apply-generic 'real-part z))
;;
(define z1 (make-from-real-imag 3 4))
(define z2 (make-from-mag-ang (magnitude 3+4i) (angle 3+4i)))
(real-part_ z1)
(real-part_ z2)