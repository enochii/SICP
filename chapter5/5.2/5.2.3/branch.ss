(define (branch-label inst) (cdr inst))
;branch
(define (make-branch inst machine;;actually machine is net needed here
                     labels flag pc)
  (let ((exp (branch-label inst)))
    (if #t;(primitive-exp? exp);;
        (let ((label (car exp)))
          (if (label-exp? label)
              (let ((insts
                     (lookup-label labels (label-exp-label label))))
                (lambda ()
                  (if (get-contents flag)
                      (set-contents! pc insts)
                      (advance-pc pc))));test fail, move pc forward
              (error "Bad BRANCH instruction -- ASSEMBLE" inst)))
        (error "Bad BRANCH instruction -- ASSEMBLE"))))