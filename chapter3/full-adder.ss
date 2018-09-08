(load "d:\\sicp\\chapter3\\3.28_or-gate.ss")
;;if we use bool value to replace 0-1, maybe the defination will be
;;more simple
(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c  e)
    (and-gate d e s)
    'ok))
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c2 c1 c-out))
  'ok)
;;这里的a和b是两个被加数对应位置上的二进制位，c-in是从被加位的右边来的进位位。
;;这一电路产生的sum是这里的a和b是两个被加数对应位置上的二进制位,c-in是从被加位
;;的右边来的进位位。这一电路产生的sum是表示对应位置之和的二进制位,而c-out是传递
;;给左边位置的进制位
(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)
(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Invalid signal" s))))
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)
(define (logical-and s1 s2)
  (cond ((= 0 s1) 0)
        ((= 0 s2) 0)
        (else 1)))