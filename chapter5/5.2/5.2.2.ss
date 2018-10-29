;ASSEMBLE
(define (assemble controller-text machine)
  (extract-labels
   controller-text
   (lambda (insts labels)
     (update-insts! insts labels machine)
     insts)))
;
(define (extract-labels text receive)
  (if (null? text)
      (recieve '() '())
      (extract-labels
       (cdr text)
       (lambda (insts labels)
         (let ((next-inst (car text)))
           (if (symbol? next-inst)
               (recieve insts
                        (cons (make-label-entry next-inst
                                                insts)
                              labels))
               (recieve (cons (make-instruction next-inst)
                              insts)
                        labels)))))))
;
(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (stack (machine 'stack))
        (ops (machine 'operations)))
    (for-each
     (lambda (inst)
       (set-instruction-excution-proc!
        inst
        (make-excution-procedure
         (instruction-text inst) labels machine
         pc flag stack ops)))
     insts)))
;
;instruction
(define (make-instruction text)
  (cons text '()))
(define (instruction-text inst)
  (car text))
(define (instruction-excution-proc inst)
  (cdr inst))
(define (set-instruction-excution-proc! inst proc)
  (set-cdr! inst proc))
;
(define (make-label-entry label-name insts)
  (cons label-name insts))
(define (lookup-label labels label-name)
  (let ((val (assoc label-name labels)))
    (if val
        (cdr val)
        (error "Unknown label -- ASSEMBLE" label-name))))