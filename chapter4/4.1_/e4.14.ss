;;e4.14 use the primitive map, take car as example, the structure of 
;;map-exprssion is like this :
;;'(map car (list (cons 1 2) (cons 2 3)))
;;car will be evaluated as (primitive #<procedure:mcar>)
;;and then our evaluator will do such action:
;;(apply map (primitive #<procedure:mcar>) ((1 . 2) (2 . 3)))
;;but scheme doeen't know what (primitive #<procedure:mcar>) is.
;;
;;and here i want to support map
