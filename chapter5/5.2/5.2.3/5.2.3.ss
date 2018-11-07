(define (make-excution-procedure inst labels machine
                                 pc flag stack ops)
  (cond ((eq? (car inst) 'assign)
         (make-assign inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'save)
         (make-save inst machine stack pc))
        ((eq? (car inst) 'restore)
         (make-restore inst machine stack pc))
        ((eq? (car inst) 'perform)
         (make-perform inst machine labels ops pc))
        (else (error "Unknown instruction type -- ASSEMBLE"
                     inst))))
;advance-pc
(define (advance-pc pc)
  (set-contents! pc (cdr (get-contents pc))))
;
;load the interfaces here
(load "d://sicp//aux_//helper.ss")
(load-all
 (map (lambda (suffix)
        (string-append ".//" suffix))
      (list
       "operation-proc.ss"
       "primitive-proc.ss"
       "assign.ss"
       "test.ss"
       "branch.ss"
       "goto.ss"
       "stack.ss"
       "perform.ss")))