;;;2.28-fringe
(define x (list (list 1 2) (list 3 4)))

(define (fringe tree)
  (cond ((null? tree) ())
        ((pair? tree) (append (fringe (car tree))
                            (fringe (cdr tree))))
        (else (list tree));;;use one value to construct a list,
        ;;;just to make the consistance to use the procedure append
        ))

;;;
(display (fringe x))
(newline)
(display (fringe (list x x)))