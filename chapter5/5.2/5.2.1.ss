;A Machine Model
(load "..//5.2.1-basic-machine.ss")
(define (make-machine
         register-names ops controller-text)
  (let ((machine (make-new-machine)))
    (for-each
     (lambda (reg-name)
       ((machine 'allocate-register) reg-name))
     register-names)
    ((machine 'install-operations) ops)
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))
;
;register
(define (make-register name)
  (let ((contents '*unassigned*))
    (define (dispatch op)
      (cond ((eq? op 'get) contents)
            ((eq? op 'set!)
             (lambda (value)
               (set! contents value)))
            (else
             (error "Unknown request -- REGISTER" message))))
    dispatch))
;
;
(define (get-contents register)
  (register 'get))
(define (set-contents! register value)
  ((register 'set!) value))
;
;stack
(define (make-stack)
  (let ((s '()))
    ;pop
    (define (pop)
      (if (null? s)
          (error "Empty stack -- POP")
          (let ((top (car s)))
            (set! s (cdr s))
            top)))
    ;push
    (define (push x)
      (set! s (cons x (cdr s))))
    ;initialize
    (define (initialize)
      (set! s '())
      'done)
    (define (dispatch message)
      (cond ((eq? message 'pop)
             (pop))
            ((eq? message 'push)
             (lambda (value)
               (push value)))
            ((eq? message 'initialize)
             (initialize))
            (else
             (error "Unknown operation -- STACK" message))))
    dispatch))
;
(define (pop stack)
  (stack 'pop))
(define (push stack x)
  ((stack 'push) x))