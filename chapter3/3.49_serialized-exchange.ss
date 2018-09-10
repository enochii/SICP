;;copy book code
(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))
;;3.49
(define (serialized-exchange acc1 acc2)
  (let ((ser1 (acc1 'serializer))
        (ser2 (acc2 'serializer)))
    (if (< (acc1 'id) (acc2 'id))
        ((ser2 (ser1 exchange))
         acc1 acc2)
        ((ser1 (ser2 exchange));;keypoint is the order of serializer
         acc1 acc2))));;;;;;;;;;;we let the smaller one inside