;;BECARE: this file is not for lazy-scheme!
(define (<=>-left exp) (cadr exp))
(define (<=>-right exp) (caddr exp))
(define (<=>? exp) 
  (or (tagged-list? exp '<) (tagged-list? exp '=) (tagged-list? exp '>)
      (tagged-list? exp '<=) (tagged-list? exp '>=)
      ))
;;below procedure transfer #t and #f into 'true and 'false 
(define (transfer boolean) (if boolean 'true 'false))
(define (eval-<=> exp env)
  (let ((sml (car exp))
        (lv  (eval_ (<=>-left exp) env))
        (rv  (eval_ (<=>-right exp) env)))
    ;(let ((result
           ;(cond ((< lv rv) -1) ((= lv rv) 0) (else 1))))
    (transfer (cond ((eq? sml '<) (< lv rv));;transfer here is cool!
                    ((eq? sml '=) (= lv rv))
                    ((eq? sml '>) (> lv rv))
                    ((eq? sml '<=) (<= lv rv))
                    ((eq? sml '>=) (>= lv rv))
                    (else 'bukeneng-nipianwo!)))))