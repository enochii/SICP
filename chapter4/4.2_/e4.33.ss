;;text-of-quotation
;;u may find the structure of lazy-stream in 4.2.3 is different from
;;list we see before, cause we represent it by procedure.
;;here are the points, when test list implementation given in 4.2 by
;;evauluating the quoted exp such like:
; (car '(a b c))
;;will produce an error.

(define (text-of-quotation exp)
  (define (make-lazy-stream l)
    (if (null? l)
        '()
        (list 'cons (list 'quote (car l));;this quote is too amazing...
              (make-lazy-stream (cdr l)))))
  ;(display exp)
  (let ((text (cadr exp)))
    (if (not (pair? text))
        text
        (make-lazy-stream text)
        )))
;(define (do-not-eval? obj) (tagged-list? obj 'do-not-eval))
;;this version can't work with '(a b) when we call actual-value to it