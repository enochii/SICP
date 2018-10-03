;;logical puzzle
(define multiple-dwelling
  '(define (multiple-dwelling)
     (let ((baker (amb 1 2 3 4))
           (cooper (amb 2 3 4 5))
           (fletcher (amb 2 3 4))
           (miller (amb 1 2 3 4 5))
           (smith (amb 1 2 3 4 5)))
       (require
        (distinct? (list baker cooper fletcher miller smith)))
       (require (> miller cooper))
       (require (not (= (abs (- smith fletcher)) 1)))
       (require (not (= (abs (- fletcher cooper)) 1)))
       (list (list 'baker baker)
             (list 'cooper cooper)
             (list 'fletcher fletcher)
             (list 'miller miller)
             (list 'smith smith)))))
;;
(pre-process multiple-dwelling)
(load "d:\\sicp\\chapter4\\4.3\\distinct-member-abs-definition.ss")