(define (test-condition inst) (cdr inst))
;
(define (make-test inst machine labels operations flag pc)
  (let ((condition (test-condition inst)))
    (if (operation-exp? condition)
         (let ((pred-proc
                (make-operation-exp
                 condition machine labels operations)))
           (lambda ()
             (set-contents! flag (pred-proc))
             (advance-pc pc)
             ))
         (error "Bad TEST instruction -- ASSEMBLE" inst))))