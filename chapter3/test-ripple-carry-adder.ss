(load "d:\\sicp\\chapter3\\3.30_ripple-carry-adder.ss")
(load "d:\\sicp\\chapter3\\3.3.4.ss")
(define (test-full-adder)
  (define a (make-wire))
  (define b (make-wire))
  (define c-in (make-wire))
  (define sum (make-wire))
  (define carry (make-wire))

  ;(define d (make-wire))(define e (make-wire))
  ;(or-gate a b d)
  (set-signal! a 0)
  (set-signal! b 1)
  (full-adder a b c-in sum carry)
  (propagate)
  (print-wires (list a b c-in sum carry))
  'full-adder-test)

(define a-list (list (make-wire) (make-wire) (make-wire)));;1 0 1
(define b-list (list (make-wire) (make-wire) (make-wire)));;1 1 0
(define c-in (make-wire))

(define xi (ripple-carry-adder a-list b-list c-in))

(set-signal! (car a-list) 1)
(set-signal! (caddr a-list) 1)
;(set-signal! (car b-list) 1)
(set-signal! (cadr b-list) 1)
(print-wires a-list)
(print-wires b-list)

(propagate)
(print-wires xi)