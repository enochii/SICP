'(rule (wheel ?department ?person)
       (and (job ?person (?department . ?type))
            (or
             (not (supervisor ?person ?boss))
             (and (supervisor ?person ?boss)
                  (not ?boss (?department . ?type))))))