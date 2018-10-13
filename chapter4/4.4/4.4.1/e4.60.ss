(define (person->string p)
  (if (null? p)
      ""
      (string-append (symbol->string (car p))
                     (person->string (cdr p)))))
(define (person>? p1 p2)
  (string>? (person->string p1) (person->string p2)))
;
(rule (als-lives-near p1 p2)
      (and (lives-near p1 p2)
           (person>? p1 p2)))