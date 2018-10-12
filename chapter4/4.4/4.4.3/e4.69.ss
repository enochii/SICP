;e4.69
(rule ((great grandson) ?x ?y)
      (and (son ?x ?grp)
           (grandson ?grp ?y)))
(rule ((great . ?rel) ?x ?y)
      (and (son ?x ?s)
           (?rel ?s ?y)))

;also, the fist rule can be replaced with
(rule ((grandson) ?grp ?grs)
      (grandson ?grp ?grs))