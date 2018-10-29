;version-1
(controller
 (assign guess (const 1))
 test-g
 (test (op good-enough?) (reg guess))
 (branch (label sqrt-done))
 (assign guess (op improve) (reg guess))
 ;
 sqrt-done)
;version-2
(controller
 (read (reg x))
 (assign guess (const 1))
 ;
 sqrt-loop;;label
 (assign sg (op square) (reg guess));square g
 (assign sr (op -) (reg sg) (reg x));sub
 (assign torlerance (op abs) (reg sr))
 (test (op <) (reg tolerance) (const 0.001))
 (branch (label sqrt-done))
 ;
 (assign ds (op /) (reg x) (reg guess));div
 (assign guess (op average) (reg ds) (reg guess));;update
 (goto (label sqrt-lopp))
 )