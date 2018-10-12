(define (qeval query frame-stream)
  (let ((qproc (get (type query) 'qeval)))
    (if qproc
        (qproc (contents query) frame-stream)
        (simple-query query frame-stream))))
;Simple queries
(define (simple-query query-pattern frame-stream)
  ;(newline)
  ;(display query-pattern)
  ;(display " || simple query line8/4.4.4.2")
  ;(newline)
  ;---text---
  (stream-flatmap;;;;;note here-------------------------------
   (lambda (frame)
     (stream-append-delayed
      (find-assertions query-pattern frame)
      (delay (apply-rules query-pattern frame))))
   frame-stream))
;Compound queries
;
;and
(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
      frame-stream
      (conjoin (rest-conjuncts conjuncts)
               (qeval (first-conjunct conjuncts)
                      frame-stream))))
;
(put 'and 'qeval conjoin)
;or
(define (disjoin disjuncts frame-stream)
  (if (empty-disjunction? disjuncts)
      the-empty-stream
      (interleaved-delayed
       (qeval (first-disjunct disjuncts) frame-stream)
       (delay (disjoin (rest-disjuncts disjuncts)
                       frame-stream)))))
;
(put 'or 'qeval disjoin)
;Filters
;not
(define (negate operands frame-stream)
  (stream-flatmap
   (lambda (frame)
     (if (stream-null? (qeval (negated-query operands)
                              (singleton-stream frame)))
         (singleton-stream frame)
         the-empty-stream))
   frame-stream))
;
(put 'not 'qeval negate)
;lisp-value
(define (lisp-value call frame-stream)
  (stream-flatmap
   (lambda (frame)
     (if (execute
          (instantiate call frame
            (lambda (v f)
              (error "Unknown pat var -- LISP-VALUE" v))))
         (singleton-stream frame)
         the-empty-stream))
   frame-stream))
;
(put 'lisp-value 'qeval lisp-value)
;execute
(define (execute exp);?
  (apply (eval (predicate exp) user-initial-environment)
         (args exp)))
;always true
(define (always-true ignore frame-stream) frame-stream)
(put 'always-true 'qeval always-true)