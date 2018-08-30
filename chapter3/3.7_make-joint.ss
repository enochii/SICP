(load "d:\\sicp\\chapter3\\3.3_make-account.ss")
(define (make-joint old-acc old-pw new-pd)
  (if (equal? "Incorrect old password"
              (old-acc old-pw 'withdraw))
      (display "Wrong password!")
      (lambda (password operation)
        (cond ((not (eq? password new-pd))
               "Incorrect password")
              (else
               (old-acc old-pw operation))))))
(define peter-acc (make-account 10000 'old))
((peter-acc 'old 'withdraw) 100)

(define paul-acc (make-joint peter-acc 'old 'new))
((paul-acc 'new 'withdraw) 100)
((paul-acc 'new 'wrong-operation) 100)
((paul-acc 'wrong-password 'deposit) 100)