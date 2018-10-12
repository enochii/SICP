;skip e4.67
;
(define (reverse x)
  (if (null? x) '()
      (append (reverse (cdr x)) (list (car x)))))
;
;e4.68
(rule (reverse (?x) (?x)));;not deep-reverse
;
(rule (reverse (?x . ?y) ?z)
      (and (reverse ?y ?u)
           (append-to-form ?u (?x) ?z)))