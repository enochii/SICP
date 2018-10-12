take the example appeared before as example:
(assert! (married minnie mickey))
(assert! (rule (married ?x ?y)
               (married ?y ?x)))

if we don't use delay, when we call (married mickey ?x), it will trigger a
infinite loop but no print. if we use delay, it will also touch off a loop
but with print:
(married mickey minnie)
(married mickey minnie)
(married mickey minnie)
...