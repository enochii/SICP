;;i test it in 3.5.4.ss, this can't work, cause in (let ((a <e1>) (b <e2>)) ...)
;;calculate b need to evaluate (stream-map f y) which depend on y, but the 
;;value of y here is '*unassigned*