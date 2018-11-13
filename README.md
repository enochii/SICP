# scheme-learning
scheme codes when learing it, mainly solutions of sicp exercises.maybe a little about tls and other interesting codes.

- 抽象 模块化 FP 数学（雾

- 过程也是一等公民。过程作为参数传递爽歪歪，ch1的cons, 丘奇计数...

- 抽象。当我们用不同的底层去实现一种数据结构比如树时，我们不必在意其实现细节，屏蔽作用使得如果我们改变底层实现不必去改动高层的代码（前提是你在实现高层代码时不考虑底层的细节

- 递归。recursive process && recursive procedure

- 尾递归。natural recursion && non-natural recursion

- 我觉得macro大概蛮有趣的，没记错的话可以改变constant identifier，而且有了这个才能用delay实现cons-stream。

- scheme对全局和函数体内的名称绑定不同，详情看chapter3\sicp_3.5.4.txt。又比如你写了：
```scheme
(define (inside-procedure)
    (define (experiment) 'xixi)
    (define xi (experiment))
    xi
)
```
当你
```scheme
(inside-procedure)
```
在R5RS下会报错说(experiment)的类型是<#undefined>，虽然跟3.5.4solve的定义出现的错误很是相似，但感觉还是有细微差别。