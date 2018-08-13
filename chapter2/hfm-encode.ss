(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
;;
(define (encode-symbol sbl tree)
  (define (search-iter result st)
    (cond ((symbol? st)
           (cons (eq? sbl st) result))
          (else
           (let ((left-res (search-iter (append result '(0)) (car st)))
                 (right-res (search-iter (append result '(1)) (cadr st))))
             (cond ((car left-res) left-res)
                   ((car right-res) right-res)
                   (else (cons #f '())))))))
  (let ((res (search-iter '() tree)))
    (if (car res)
        (cdr res)
        (error "No such symbol in the given hfm-tree -> " sbl))))
(load "d:\\sicp\\chapter2\\hfm-decode.ss")
(display (encode '(c b a h e f g d) hfm-tree))
(display (encode '(c b i h e f g d) hfm-tree))