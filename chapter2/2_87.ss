;;we write =zero? before, so we just write it for poly
(define (update-polynomial-package)
  (define (=zero?-poly p)
    (if (empty-termlist? p)
        #t
        ;;(let ((t (first-term p)))
        (if (=zero? (coeff (first-term p)));;make it general
            (=zero?-poly (rest-terms p))
            #f)))
  (put '=zero? '(polynomial)
       =zero?-poly)
  'done)
;;we are supposed to solve the problem when there are poly that have polynomial
;;coeff, when we use =zero? in =zero?-poly, i think it should have the ability
;;to solve poly like ((2z^2 + 3z}y^3 + 2}x + 3}