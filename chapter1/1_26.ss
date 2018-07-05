;sicp 妨习1.24
;重写femat-test的expmod方法如下，改了下分支的写法，对算法性能影响不大
(define (expmod base exp m)
  (if (= exp 0) 1
        (if (even? exp)
            (remainder 
             (* (expmod base (/ exp 2) m)
               (expmod base (/ exp 2) m))
             m)
            (remainder (* base (expmod base (- exp 1) m)) m)
            )))
;这里没用square，导致算法复杂度由log(n)变为了n，明显没用square后递归结构由
;linear recursion变为了tree recursion。第一想法是跟指数扯上关系，不过回头
;想，耗时操作主要是乘法计算，那问题就很清晰了，square利用了上一次的计算结果，所
;以是对数次的*，而重写后只是简单地一次次累乘，故是线性次的*