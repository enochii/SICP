(rule (grandson ?grandpa ?grds)
      (and (son ?grandpa ?dad)
           (son ?dad ?grds)))
;
(rule (son ?mom ?s)
      (and (wife ?dad ?mom)
           (son ?dad ?s)))