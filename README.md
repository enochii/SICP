# scheme-learning
some codes about sicp

- 抽象 模块化 FP 数学（雾

- 过程也是一等公民。过程作为参数传递爽歪歪，在ch1的cons中看到的procedure表示法还是蛮神奇的，所谓过程即数据，在丘奇计数中也高潮不断，于是技痒在ch2的用树结构表示集合也用了list和procedure两种表示法。

- 抽象的魔力。当我们用不同的底层去实现一种数据结构比如树时，我们不必在意其实现细节，屏蔽作用使得如果我们改变底层实现不必去改动高层的代码（前提是你在实现高层代码时不考虑底层的细节

- 递归的魔力。说来最近写到ch2才回过头去品味迭代过程和递归过程，虽然scheme实现迭代时一般也是递归语法，但这和我们平时说的递归（计算）不甚相同。迭代只需常量栈空间，记录的只是常数个参数。其实递归讲道理也是一种美妙的抽象，它屏蔽了下一层的实现细节，你只需要考虑当前层和下一层的关系，再弄个出口就o**k了。

- 尾递归可以优化成循环，这也可以稍稍看出递归和循环的微妙关系。

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