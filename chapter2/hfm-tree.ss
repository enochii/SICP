;;a sorted set version just support adjoin-set, of which elements have
;;keyword and weight so that we can use it in hfm alg.
(define (adjoin-set x tree)
  (if (null? tree)
      (list x)
      (let ((e (car tree)))
        (if (<= (weight-leaf x) (weight-leaf e))
            (cons x tree)
            (cons e (adjoin-set x (cdr tree)))))))
(define (combine-leaf x y)
  (make-leaf (list (symbol-leaf x) (symbol-leaf y))
             (+ (weight-leaf x) (weight-leaf y))))

;;
(define (make-leaf symbol weight)
  (list 'leaf;;logo
        symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))
;;
(define (hfm elts)
  ;;elts has been sorted
  (if (null? (cdr elts))
      (car elts);done
      (hfm (adjoin-set (combine-leaf (car elts) (cadr elts))
                 (cddr elts)))))
;;test
(define elts (list 
              (make-leaf 'a 1) (make-leaf 'b 1) (make-leaf 'c 1)
              (make-leaf 'd 1) (make-leaf 'e 1) (make-leaf 'f 1)
              (make-leaf 'g 3) (make-leaf 'h 8)))
(display (hfm elts))