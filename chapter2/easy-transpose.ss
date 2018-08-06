(define (transpose mat)
  (apply map (cons list mat)))
;;
;(display (transpose '((1 2 3) (4 5 6) (7 8 9))))
;(display (apply map (cons list '((1 2) (3 4)))))
;;
;(newline)
(cons list '((1 2) (3 4)));;->(1)
;;(#<procedure:list> (1 2) (3 4))

'(list (1 2) (3 4));;->(2)
;;(list (1 2) (3 4))
;;
;(apply + '(1 2 3))
;(display (apply map '(list (1 2) (3 4))))

;;
;;BECARE:case 1 is different from case 2,
;;in case 2, list is not a procedure