;e4.15
;;define try like this:
(define (try p)
  (if (halts p p)
      (run-forever)
      'halted))
;;and eval expression (try try)
;;let us consider two cases, 
;;0.if try "halt" on try, then (halts try try) return true, so (try try) return 
;;(frun-forever), that's to say, try doesn't halt ontry, which conflicts with 
;;what we predicate.
;;1.if try doesn't not "halt" on try, then (halts try try) return false, 
;;(try try) return 'halted, and touch off a conflict again.