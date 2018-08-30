(define balance 100)
(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
;(withdraw 10)
;(withdraw 10)
;(withdraw 10)
;;new-withdraw -- v1
(define new-withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))
;;
;(new-withdraw 10)
;(new-withdraw 10)
;(new-withdraw 10)
;;new-withdraw -- v2, this version is wrong
(define (new-withdraw_ amount)
  (let ((balance 100))
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
;(new-withdraw_ 10)
;(new-withdraw_ 10)
;;make-withdraw
(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
(define w1 (make-withdraw 100))
(define w2 (make-withdraw 80))
(w1 10)
(w1 10)
;;
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define dispatch
    (lambda (operation)
      (cond ((eq? operation 'withdraw)
             withdraw)
            ((eq? operation 'deposit)
             deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         operation)))))
  dispatch)
(define acc (make-account 100))
((acc 'withdraw) 50)
((acc 'withdraw) 50)
((acc 'deposit) 50)