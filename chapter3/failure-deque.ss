(define (make-deque) (list '() '() '()))
(define (front-ptr d) (car d))
(define (penul-timate-ptr d) (cadr d))
(define (rear-ptr d) (caddr d))
;;select
(define (empty-deque? d) (null? (front-ptr d)))
(define (front-deque d) (car (front-ptr d)))
(define (rear-deque d) (car (rear-ptr d)))
;;mutate
(define (front-insert-deque! d item)
  (let ((new (cons item (front-ptr d))))
    ;(set-car! d new);;we need to judge if it's empty, so can't do it at first
    (if (empty-deque? d)
        (begin (set-car! d new);;this is a common operation...
               (set-car! (cddr d) new)
               d)
        (begin (set-car! d new)
               (if (null? (penul-timate-ptr d));;if (= length 1)
                   (set-car! (cdr d) new));;....key-point
               d))))
(load "d:\\sicp\\chapter3\\deque-test.ss")

(define (rear-insert-deque! d item)
  (let ((new (cons item '())))
    (if (empty-deque? d);;actually, when deque is empty, rear and front insert
        (begin (set-car! d new);;is the same, so we can define a proc to do this job
               (set-car! (cddr d) new)
               d)
        (begin (set-cdr! (rear-ptr d) new)
               (set-car! (cdr d) (rear-ptr d))
               (set-car! (cddr d) (cdr (penul-timate-ptr d)))
               d))))

(define (front-delete-deque! d)
  (if (empty-deque? d)
      (error "Front delete in empty deque" d)
      (begin (if (equal? (front-ptr d) (penul-timate-ptr d));;= 2 length
                 (set-car! (cdr d) '()))
             (set-car! d (cdr (front-ptr d)))
             (if (empty-deque? d)
                 (set-car! (cddr d) '()))
             d)))
(define (rear-delete-deque! d)
  (if (empty-deque? d)
      (error "Front delete in empty deque" d)
      