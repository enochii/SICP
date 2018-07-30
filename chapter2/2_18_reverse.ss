;;;2.18
;;;reverse
(load "d:\\sicp\\chapter2\\list_base.ss")
(define (rever l)
  ;;;dont't use last-pair, cause it will make the linear 
  ;;;procedure becomes O(n^2).probably use the append procedre 
  ;;;to make the final return value type be a list
  (if (null? l)
      (list)
      (append (rever (cdr l)) 
                 (list (car l)))
            ))
    
;;;
;(display (rever (cons 3 one-through-four)))
