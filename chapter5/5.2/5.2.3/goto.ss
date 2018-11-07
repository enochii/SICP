;destinations of branch and goto are a little different, u can find
;branch supports label only while goto supports label and register
;with the content of a label, i think that's mainly because we use
;the goto to simulate recursion so we need the second form.

;goto
(define (goto-dest goto-inst)
  (cadr goto-inst))
;
(define (make-goto inst machine labels pc)
  (let ((dest (goto-dest inst)))
    (cond ((label-exp? dest)
           (let ((insts
                  (lookup-label labels (label-exp-label dest))))
             (lambda ()
               (set-contents! pc insts)
               ;(advance-pc pc)//here don't need to advance pc
               )))
          ((register-exp? dest)
           (let ((register
                  (get-register machine (register-exp-reg dest))))
             (lambda ()
               ;;the contents of register has already been pointer
               ;;to insts when we do the assignment
               (set-contents! pc (get-contents register))
               )))
          (else (error "Bad GOTO instruction -- ASSEMBLE" inst)))))