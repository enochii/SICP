;;search-proc is a little troublesome...
;;let we read it from inside at first
;;a : starting from type-tags, for example, if type-tags is a list like '(a b c), we get '((a . cur-type) (b . cur-type) (c . cur-type))
;;b : from result in a, we use map and get-coercion get a list combined by procedures, each procedure trans a type to cur-type
;;c : we apply each procedure to appropriate arg, we get a list, it's combined by args but they have been transformed into cur-type
;;   finally we can apply proc to the args
(define (search-proc op len type-tags)
  (if (null? type-tags)
      '(#f)
      (let ((cur-type (car type-tags)))
        (let ((proc (get op (build-list len cur-type))))
          (if proc;;we can use procedure do-flat here, judging first can fix the bug
              (cons #t
                    (apply proc (map apply ;;c
                                     (map (lambda (pair);;b
                                            (if (eq? (car pair) (cadr pair))
                                                (lambda (x) x)
                                                (get-coercion (car pair) (cdr pair));;here i dont consider that get-coercion may fail...
                                                ;;if want, may write another procedure to rewrite this part, please see procedure do-flat below
                                            ))
                                          (map (lambda (x);;a
                                                 (list x cur-type))
                                               type-tags))
                                     (map list args);;use list cause of second argument of apply is 'list
                                      )))
              (search op len (cdr type-tags)))))))
  
(define (apply-generic op args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc args)
          (if (same-type? type-tags)
              (error "No method for these types"
                     (list op type-tags))
              (let ((res 
                     (search-proc op (length type-tags) type-tags args)
                     ))
                (if (car res)
                    (cdr res)
                    (error "no method for these types"
                           (list op type-tags)))))))))
;(display (map apply (list - +) '(( 2 3) (-1 3))));;(-1 2)
(define (self x)
  x)
(define (neg x)
  (- x))
(display (map apply (list self neg) (map list '(1 2))))

;;replace a + b part, to judge if args can all be transformed to cur-type
(define (do-flat type-tags cur-type)
  (define (iter type-tags cur-type)
    (if (null? type-tags)
        '()
        (let ((force-proc (get-coercion (car type-tags) cur-type)))
          (if force-proc
              (cons force-proc (iter (cdr type-tags) cur-type))
              '();;we have an arg that can trans into cur-type
              ))))
  (let ((return (iter type-tags cur-type)))
    (cons (= (length return) (length type-tags));;return true if all arguments can trans into cur-type
          return)))

;;2.82 says that there are still some cases are not considered in this procedure
;;for example, we have a op that match '(int complex rat}, and our args are
;;'(int int rat}, this is ok, but the procedure can not work