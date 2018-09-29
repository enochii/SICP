;;streams as lazy lists
;;this file is a external lazy-stream package for extension
;
(define (upgrade-env env)
  (define upgrade-list 
    (list
     '(define (cons x y) (scons 'stream (lambda (m) (m x y))))
     
     ;;e4.34-1.ss
     ;'(define (cons x y) (scons (scons 'stream x) (lambda (m) (m x y))))
     '(define (car z) ((scdr z) (lambda (p q) p)))
     '(define (cdr z) ((scdr z) (lambda (p q) q)))
     
     '(define (length z) "imp me")
     '(define (list-ref items n)
          (if (null? items)
              (display "stream too short!")
              (if (= n 0)
                  (car items)
                  (list-ref (cdr items) (- n 1)))))
     '(define (map proc items)
        (if (null? items)
            '()
            (cons (proc (car items)) (map proc (cdr items)))))
     '(define (scale-list items factor)
        (map (lambda (x) (* factor x)) items))
     '(define (add-lists list1 list2)
        (cond ((null? list1) list2)
              ((null? list2) list1)
              (else (cons (+ (car list1) (car list2))
                          (add-lists (cdr list1) (cdr list2))))))
     '(define (print-stream-head str num)
        (if (= num 0)
            'done
            (begin (display (car str))(display " ")
                   (print-stream-head (cdr str) (- num 1)))))
     '(define ones (cons 1 ones))
     ;'(define ints (add-lists ones (cons 0 ints)))
     ;;integral
     '(define (integral integrand init-val dt)
        (define int
          (cons init-val
                (add-lists (scale-list integrand dt)
                           int)))
        int)
     '(define (solve f y0 dt)
        (define y (integral dy y0 dt))
        (define dy (map f y))
        y)
     ;;and in solution of 3.5.4, which run in scheme underlying env, the above 
     ;;syntax of solve is not allowed, but works well here... in 3.5.4 i have to
     ;;use a fake dy.
     ;'(list-ref (solve (lambda (x) x) 1 0.001) 1000)
     ;;; M-Eval input:
     ;(list-ref (solve (lambda (x) x) 1 0.001) 1000)

     ;;; M-Eval output:
     ;2.716923932235896
     ;;
     ;;maybe we need a proc -- list to prefect our lazy-stream package
     ;;here i don't know how to make a args with variable length
     ))
  (for-each (lambda (def) (eval_ def env))
            upgrade-list))