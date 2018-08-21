;;sparse, dense
;;2.90
(define (same-variable? x y)
  (and (symbol? x) (symbol? y) (eq? x y)))
;;persudo get....
(define (get op type-tags)
  (cond ((and (eq? op 'add-poly) (equal? type-tags '(dense dense)))
         add-poly-dense)
        ((and (eq? op 'add-poly) (equal? type-tags '(sparse sparse)))
         add-poly-sparse)
        (else 'error)))
(define (apply-generic op . args)
  (apply (get op (map type-tag args)) (map contents args)))

(define (variable poly-without-tag) (car poly-without-tag))
(define (term-list poly-without-tag) (cdr poly-without-tag))

(define (attach-tag poly-type x) (cons poly-type x))
(define (type-tag x) (car x));;remove the type-tag
(define (contents x) (cdr x))
(define (add-poly p1 p2);;;;;general-add-poly
  (let ((c1 (contents p1))
        (c2 (contents p2)))
    (if (same-variable? (variable c1) (variable c2))
        (apply-generic 'add-poly p1 p2)
        (error "different var..."))))
(define (the-empty-termlist) '())
(define (empty-termlist? term-list) (null? term-list))
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))
(define (make-poly_ var term-list) (cons var term-list))

(load "d:\\sicp\\chapter2\\split-list.ss")
;;dense-internal-procedure
(define (tag-dense x) (attach-tag 'dense x))
(define (add-poly-dense poly1 poly2)
  (tag-dense (make-poly_ (variable poly1) (add-terms-dense (term-list poly1) (term-list poly2)))))
(define (add-terms-dense terms1 terms2)
   (let ((len1 (length terms1))
         (len2 (length terms2)))
     (cond ((> len1 len2)
            (let ((result-pair (split-pair (- len1 len2) terms1)))
              (append (car result-pair)
                      (map add (cdr result-pair) terms2))))
           ((< len1 len2)
            (let ((result-pair (split-list (- len2 len1) terms2)))
              (append (car result-pair)
                      (map add terms1 (cdr result-pair)))))
           (else 
            (map add terms1 terms2)))))

;;sparse-internal-procedure
(define (tag-sparse x) (attach-tag 'sparse x))
(define (adjoin-term term terms);;sparse
  (cons term terms))
(define (add-poly-sparse poly1 poly2)
  (tag-sparse (make-poly_ (variable poly1) (add-terms-sparse (term-list poly1) (term-list poly2)))))
(define (add-terms-sparse terms1 terms2)
   (cond ((empty-termlist? terms1) terms2)
         ((empty-termlist? terms2) terms1)
         (else 
          (let ((t1 (first-term terms1))
                (t2 (first-term terms2)))
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
(define (make-poly-dense var term-list)
  (tag-dense (make-poly_ var term-list)))
(define (make-poly-sparse var term-list)
  (tag-sparse (make-poly_ var term-list)))
;;helper of sparse-poly
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))


(define (test-code)
  (define p1 (make-poly-dense 'x '(1 2 3 4)))
  (define p2 (make-poly-dense 'x '(2 3 4 5 5)))
  (define p3 (make-poly-sparse 'x '((2 4) (0 8))))
  (define p4 (make-poly-sparse 'x '((2 3) (1 2) (0 5))))
  ;(display (contents p1))
  ;(display (add-terms-dense '(1 2 3) '(2 3 4 5)))
  ;(display (add-terms-sparse '((2 4) (0 8)) '((2 3) (1 2) (0 5))))
  ;(display (add-poly p1 p2))
  ;(display (add-poly-dense (contents p1) (contents p2)))
  (display (add-poly p1 p2))
  (display (add-poly p3 p4))
  'done)
(define add +)
(test-code)