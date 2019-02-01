# scheme-learning
scheme codes when learing it, mainly solutions of sicp exercises.maybe a little about tls and other interesting codes.

- macro大概蛮有趣的，没记错的话可以改变constant identifier，而且有了这个才能用delay实现cons-stream。

- scheme对全局和函数体内的名称绑定不同
```scheme
(define (inside-procedure)
    (define (experiment) 'xixi)
    (define xi (experiment))
    xi
)
```
```scheme
(inside-procedure)
```
