(load "d:\\sicp\\chapter2\\common-poly.ss")
(define (first-term-dense term-list)
  (make-term (- (length term-list) 1) (car term-list)))

(load "d:\\sicp\\chapter2\\split-list.ss");;build-list
(define (mul-term-by-terms-dense term terms)
  (append (map (lambda (x) (mul x (coeff term))) terms)
          (build-list-from-num-val (order term) 0)))
(define (add-terms-dense terms1 terms2);;test code before
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

(define (make-negative-terms-dense term-list)
  (map make-negative term-list))


;;sub-terms
(define (sub-terms-dense l1 l2)
  (add-terms-dense l1 (make-negative-terms-dense l2)))

(define (test-code)
  (display (sub-terms-dense '(2 3 4) '(1 2 3 4))) (newline)
  )
(test-code)