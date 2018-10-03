;;e4.42
;;liers puzzle
;;betty
(define e4.42
  '(define (liers)
     (let ((all (amb 1 2 3 4 5)))
       (let ((a (amb 1 2 3 4 5));;betty
             (b (amb 1 2 3 4 5));;ethel
             (c (amb 1 2 3 4 5));;joan
             (d (amb 1 2 3 4 5));;kitty
             (e (amb 1 2 3 4 5)));;mary
         (require (xor (= d 2) (= a 3)))
         (require (xor (= b 1) (= c 2)))
         (require (xor (= c 3) (= b 5)))
         (require (xor (= d 2) (= e 4)))
         (require (xor (= e 4) (= a 1)))
         (require (distinct? (list a b c d e)))
         (list (list 'betty a)
               (list 'ethel b)
               (list 'joan c)
               (list 'kitty d)
               (list 'mary e))))))

(load "d:\\sicp\\chapter4\\4.3\\and-or.ss")
(pre-process e4.42)