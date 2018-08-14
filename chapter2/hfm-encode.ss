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
           (let ((left-res (search-iter (append result '(0)) (car st))))
             (if (car left-res) left-res
                 (let ((right-res (search-iter (append result '(1)) (cadr st))))
                   (if (car right-res) right-res
                       (cons #f '()))))))))
  ;;
  (let ((res (search-iter '() tree)))
    (if (car res)
        (cdr res)
        (error "No such symbol in the given hfm-tree -> " sbl))))
(load "d:\\sicp\\chapter2\\hfm-decode.ss")
;(display (decode (encode '(c b a h e f g d) hfm-tree) hfm-tree))
;(display (encode '(c b i h e f g d) hfm-tree))
;;In my eyes, if we replace "append" with "cons" and "reverse",
;;it may be faster