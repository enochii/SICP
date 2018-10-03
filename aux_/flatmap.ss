(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))
(load "d:\\sicp\\aux_\\accumulate.ss")