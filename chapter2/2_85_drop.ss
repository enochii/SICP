;(ceiling 1.2)
;(floor 1.2)
;;
(define put list)
(load "d:\\sicp\\chapter2\\2_83_raise.ss")
;;internal procedure in complex-package
(define (project-complex cp)
  (make-real (real-part_ cp)))
(put 'project '(complex) project-complex)
;;... in real-package
(define (project-real r)
  ;;todo ---- real -> rational
  'xixi)
(put 'project '(real) project-real)
;;... in rational-package
(define (project-rational rat)
  (quotient (number rat) (denom rat)))
(put 'project '(rational) project-rational)
;;general project outside packages above
(define (project x)
  (apply-generic 'project x))
;;
(load "d:\\sicp\\chapter2\\2_78-80.ss");;equ?
(define (have-drop-proc? x)
  ;(equ? x (raise (project x))))
  (let ((type (type-tag x)))
    (or (eq? type 'complex)
        (eq? type 'real)
        (eq? type 'rational)
        )))
(define (drop x);;if can drop x, return the final result, else x
  (define (iter x)
    (if (not (have-drop-proc? x))
        x
        (let ((result (project x)))
          (if (equ? (raise result) x)
              (iter result)
              x))))
  (iter x));;drop x until can't
;;
(define (new-apply-generic op args)
  (apply-generic op (map drop args)))