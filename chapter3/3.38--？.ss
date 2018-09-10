;;3.38
;a)35 40 45 50

;;3.39
;;101 121

;;3.40
;;100 1000 10000 100000 1000000
;;make-serializer 1000000

;;3.43 ...

;;3.44
;;i think maybe transfer don't calculate the difference of balance inside, that's
;;to say, we seperate calculate difference and deposit/withdraw,so there is no 
;;such problem like exchange

;;3.45
;;see the defination of serializer, when call serialized-exchange, it will use 
;;internal serializer twice, the second time is called when first call is not 
;;done which will touch off conflict.