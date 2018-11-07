;test
(load "d://sicp//aux_//helper.ss")
(load-all
 (list
  ".//5.2.3.ss"
  "..//5.2.1.ss"
  "..//5.2.2.ss"))
;
(define gcd-machine
  (make-machine
   '(a b t)
   (list (list 'rem remainder) (list '= =))
   '(test-b
     (test (op =) (reg b) (const 0))
     (branch (label gcd-done))
     (assign t (op rem) (reg a) (reg b))
     (assign a (reg b))
     (assign b (reg t))
     (goto (label test-b))
     gcd-done)))

(set-register-contents! gcd-machine 'a 206)
(set-register-contents! gcd-machine 'b 40)

(start gcd-machine)
(get-register-contents gcd-machine 'a)