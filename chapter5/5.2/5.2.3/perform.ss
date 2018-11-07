(define (perform-action perform-inst)
  (cdr perform-inst))
;
(define (make-perform inst machine labels operations pc)
  (let ((act (perform-action inst)))
    (cond ((operation-exp? act)
           (let ((res-proc
                  (make-operation-exp
                   act machine labels operations)))
             (lambda ()
               (;display
                (res-proc))
               (advance-pc pc))))
          ((primitive-exp? act)
           ..);;nothing about primitive expression
          (else
           (error "Bad PERFORM instruction -- ASSEMBLE")))))