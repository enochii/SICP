(load "d:\\sicp\\chapter3\\full-adder.ss")
(load "d:\\sicp\\chapter3\\agenda.ss")
(load "d:\\sicp\\chapter3\\wire.ss")
(load "d:\\sicp\\chapter3\\after-delay.ss")
;;
(load "d:\\sicp\\chapter3\\probe.ss")
(define (print-wires xi) (map get-signal xi))
(define the-agenda (make-agenda))
(define (test-code-1)
  ;(define the-agenda (make-agenda))
  (define input1 (make-wire))
  (define input2 (make-wire))
  ;;
  (define sum (make-wire))
  (define carry (make-wire))
  (probe 'sum sum)
  (probe 'carry carry)
  ;;
  (half-adder input1 input2 sum carry)
  
  (set-signal! input1 1)
  (propagate)
  ;;
  (set-signal! input2 1)
  (propagate)
  'test-code-1)
;(test-code-1)