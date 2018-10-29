(data-paths
 (resgisters
  ((name a)
   (buttons ((name a<-b) (source (register b)))))
  ((name b)
   (buttons ((name b<-t) (source (register t)))))
  ((name t)
   (buttons ((name t<-r) (source (operation rem)))))
  )
 ;
 (operations
  ((name rem) (inputs (register a) (register b)))
  ((name =) (inputs (register b) (constant 0))))
 )
 ;
 (controller
  test-b                     ;label
  (test =)                   ;test
  (branch (label gcd-done))
  (t<-r)
  (a<-b)
  (b<-t)
  (goto (label test-b))
  gcd-done)
 ;
 ;a clearer format
 (controller
  test-b ;label
  ;
  (test (op =) (reg b) (constant 0))
  (branch (label gcd-done))
  (assign t (op rem) (reg a) (reg b))
  (assign a (reg b))
  (assign b (reg t))
  (goto (label test-b))
  gcd-done
  )