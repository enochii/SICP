(define (output . list)
  (map (lambda (x) (display x)(display " ")) list)
  (newline))

;;error is not supported in r5rs
(define (error . list)
  (output (cons 'error! list)))
;(error 'sch 'is 'a 'sb)
;
;negate
(define (negate func)
  (lambda (x . y)
    (not (apply func (cons x y)))))
;
;(define not-eq? (negate eq?))
;(define not-empty? (negate empty?))
;(not-empty? '())
;(not-empty? '(1))

;
;a interface for easierly load several files
(define (load-all files)
  (if (null? files)
      'done
      (begin (load (car files))
             (load-all (cdr files)))))
;
(define (tagged-list? x tag)
  (and (pair? x) (eq? (car x) tag)))