;compared with definition of ones, we will know the difference. definition
;of ones tries to use itself to define it recursively, while here we just
;wana get the old value of THE-ASSERTIONS so we can extend it. so if we 
'(define (add-assertion! assertion)
   (store-assertion-in-index assertion)
   (set! THE-ASSERTIONS
         (cons-stream assertion THE-ASSERITONS))
   'ok)
;it will like ones, use THE-ASSERTIONS that has been set to define itself,
;which is not we want, and get an infinite stream