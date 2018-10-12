;some rules defined from 4.4.1-4.4.3

;outranked-by
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (supervisor ?staff-person middle-manager)
               (outranked-by ?middle-manager ?boss))))

;lives-near
(rule (lives-near ?person-1 ?person-2)
      (and (address ?person-1 (?town . ?rest-1))
           (address ?person-2 (?town . ?rest-2))
           (not (same ?person-1 ?person-2))))

;wheel
(rule (wheel ?person)
      (and (supervisor ?middle-manager ?person)
           (supervisor ?x ?middle-manager)))

;append-to-form
(rule (append-to-form () ?y ?y))

(rule (append-to-form (?u . ?v) ?x (?u . ?y))
      (append-to-form ?v ?x ?y))
;
(rule (same ?x ?x))