;(const 4)
;
(define (extract-labels text receive)
  (if (null? text)
      (recieve '() '())
      (extract-labels
       (cdr text)
       (lambda (insts labels)
         (let ((next-inst (car text)))
           (if (symbol? next-inst)
               (if (assoc next-inst labels)
                   (error
                    "Redefine a existed label" next-inst)
                   (recieve insts
                            (cons (make-label-entry next-inst
                                                    insts)
                                  labels)))
               (recieve (cons (make-instruction next-inst)
                              insts)
                        labels)))))))