(define (constant value connector)
  (define (me request)
    (error "Unknown request -- CONSTANT" request))
  ;(connect connector me)
  (set-value! connector value me);;this will call (me 'i-have-a-value)
  me);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;which touch off a error! actually we
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; can note the previous code to avoid

;;line 4 in book code exists, but to tell the truth, i think we don't need it,
;;cause we don't need to change value of connector. the only imperction is 
;;that when u use the return value of constant to call (forget-value! connector
;;return-value-of-the-constant), the connector will be reset to default-state.
;;if we still want to get entangled with it, we can let the constant-proc return
;;void or others instead of me. last but not least, even we hold line 4, the imperction
;;above still exist, so, what do u think