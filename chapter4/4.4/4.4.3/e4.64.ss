;;the above outranked-by change the order of and-clauses, and when we input
;;(outranked-by (Bitdiddle Ben) ?who), it will use the and to match, which
;;will call (outranked-by (Bitdiddle Ben) ?boss) and generate a frame with
;;a binding between ?who and ?boss, so the call we mentioned is just like 
;;(outranked-by (Bitdiddle Ben) ?who), which make a infinite loop