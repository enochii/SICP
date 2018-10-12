(define (uniquely-asserted operands frame-stream)
  (stream-flatmap
   (lambda (frame)
     (let ((result (qeval (car operands) (singleton-stream frame))))
       ;(display pattern)
       (cond ((stream-null? result)
              the-empty-stream)
             ((stream-null?
                (stream-cdr
                 result))
              result)
             (else
              the-empty-stream))))
   frame-stream))
(put 'unique 'qeval uniquely-asserted)
;test unique
;;; Query input
'(and (supervisor ?person ?boss) (unique (supervisor ?others ?boss)))
;BECARE: here we use a extra var ?others but not ?person, cause if
;we use ?person, the frame will never be extended.
;;; Query results
'(and (supervisor (cratchet robert) (scrooge eben))
      (unique (supervisor (cratchet robert) (scrooge eben))))
'(and (supervisor (reasoner louis) (hacker alyssa p))
      (unique (supervisor (reasoner louis) (hacker alyssa p))))
;;;use ?person to replace ?others
;;; Query input
'(and (supervisor ?person ?boss) (unique (supervisor ?person ?boss)))
;;; Query results
'(and (supervisor (aull dewitt) (warbucks oliver))
      (unique (supervisor (aull dewitt) (warbucks oliver))))
'(and (supervisor (cratchet robert) (scrooge eben)) 
      (unique (supervisor (cratchet robert) (scrooge eben))))
'(and (supervisor (scrooge eben) (warbucks oliver)) 
      (unique (supervisor (scrooge eben) (warbucks oliver))))
'(and (supervisor (bitdiddle ben) (warbucks oliver)) 
      (unique (supervisor (bitdiddle ben) (warbucks oliver))))
'(and (supervisor (reasoner louis) (hacker alyssa p)) 
      (unique (supervisor (reasoner louis) (hacker alyssa p))))
'(and (supervisor (tweakit lem e) (bitdiddle ben)) 
      (unique (supervisor (tweakit lem e) (bitdiddle ben))))
'(and (supervisor (fect cy d) (bitdiddle ben))
      (unique (supervisor (fect cy d) (bitdiddle ben))))
'(and (supervisor (hacker alyssa p) (bitdiddle ben)) 
      (unique (supervisor (hacker alyssa p) (bitdiddle ben))))