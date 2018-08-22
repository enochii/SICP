(load "d:\\sicp\\chapter2\\common-poly.ss")
;;sparse-poly
(define (first-term-sparse term-list)
  (car term-list))
(define (mul-term-by-terms-sparse term terms)
  (map (lambda (term-pair) (list (+ (order term)
                                    (order term-pair))
                                 (mul (coeff term)
                                      (coeff term-pair))))
       terms))

(define (make-negative-terms-sparse term-list)
  (map (lambda (term-pair) (list (order term-pair)
                                 (make-negative (coeff term-pair)))) term-list))
;;add-terms
(define (add-terms-sparse terms1 terms2)
   (cond ((empty-termlist? terms1) terms2)
         ((empty-termlist? terms2) terms1)
         (else 
          (let ((t1 (first-term-sparse terms1))
                (t2 (first-term-sparse terms2)))
            (cond ((> (order t1) (order t2))
                   (adjoin-term t1
                                (add-terms-sparse (rest-terms terms1)
                                                  terms2)))
                  ((< (order t1) (order t2))
                   (adjoin-term t2
                                (add-terms-sparse terms1
                                                  (rest-terms terms2))))
                  (else
                   (adjoin-term (make-term (order t1)
                                           (add (coeff t1) (coeff t2)))
                                (add-terms-sparse (rest-terms terms1)
                                                  (rest-terms terms2)))))))))
;;sub-terms
(define (sub-terms-sparse l1 l2)
  (filter (lambda (term) (not (=zero? (coeff term))))
          (add-terms-sparse l1 (make-negative-terms-sparse l2))))

(define (test-code)
  (display (make-negative-terms-sparse '((3 2) (2 3))))
  (display (sub-terms-sparse '((3 2) (1 2)) '((3 1) (1 1) (0 2))))
  )
;(test-code)

;;
(define (adjoin-term term terms) (cons term terms))
(define first-term first-term-sparse)
(define mul-term-by-terms mul-term-by-terms-sparse)
(define sub-terms sub-terms-sparse)

(define x (mul-term-by-terms '(2 3) '((2 3) (0 4))))
;(display (adjoin-term '(5 3) x))
;(display (first-term x))
;(display (sub-terms x '((0 3))))