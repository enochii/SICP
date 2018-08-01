;;;2.29
(define (make-mobile left right)
  (list left right))
(define (make-branch len struct)
  (list len struct))
;;;a)select-fun
(define left-branch car)
(define right-branch cadr)
(define branch-len car)
(define branch-struct cadr)
;;;b)total-weight
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))
(define (branch-weight branch)
  (if (hangs-another-mobile? branch)
      (total-weight (branch-struct branch))
      (branch-struct branch)))
(define (hangs-another-mobile? branch)
  (pair? (branch-struct branch)))
;;;c)balanced?
;;branch-value
(define (branch-value branch)
  (* (branch-len branch) (branch-weight branch)))

(define (balanced? mobile)
  (cond ((not (= (branch-value (left-branch mobile))
           (branch-value (right-branch mobile))))
         #f)
        ((and (hangs-another-mobile? (left-branch mobile))
         (not (balanced? (branch-struct (left-branch mobile)))))
         #f)
        ((and (hangs-another-mobile? (right-branch mobile))
         (not (balanced? (branch-struct (right-branch mobile)))))
         #f)
        (else #t)))
;;;
(define balance-mobile (make-mobile (make-branch 11 10)
                                          (make-branch 10 10)))
(balanced? balance-mobile)

;;;BECARE:here we will find that we repeatedly calculate the weight
;;;of nearly all nodes, just like a recursive fabinacci procedure
;;;without memory list. but right now i don't how to solve it.
                                            
                                            