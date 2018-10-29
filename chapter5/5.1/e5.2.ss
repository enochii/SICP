;skip 5.1
;
;e5.2
(define (fact n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* product counter)
              (+ counter 1))))
  (iter 1 1))
;
;for a fact call, actually, value of n will not be changed while computing
;for convenience, here i use symbol n to represent itself.
(data-paths
 (registers
  ((name p)
   (buttons (name upd-p) (source (operation *))))
  ((name counter)
   (buttons (name upd-c) (source (operation +))))
  ;n?
  )
 ;there may be some conflicts when name var...
 (operations
  ((name *) (inputs (register p) (register c)))
  ((name +) (inputs (register c) (constant 1)))
  ((name >) (inputs (register c) n));;;todo
  )
 )
;
(controller
 test-c
 (branch (label fact-done))
 (udp-p)
 (udp-c)
 (goto (label test-c))
 ;
 fact-cone)
;
;new-format
(controller
 test-c
 (test (op >) (reg c) n)
 (branch (label fact-done))
 (assign p (op *) (reg p) (reg c))
 (assign c (op +) (reg c) (const 1))
 (goto (label test-c))
 ;
 fact-done)