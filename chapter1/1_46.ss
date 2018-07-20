(define (iter-impro good-enough? try x)
  (define (iter guess)
    (let ((next (try guess)))
      (if (good-enough? guess next)
          next
          (iter next))))
 ; (lambda (x)
    (iter x));)
;;;fixed-point
(define (fixed-point f guess)
  (define (f-good? now next)
    (< (abs (- now next)) tolerance))
  (define (f-try now)
    (f now))
  (iter-impro f-good? f-try guess))

(define tolerance 0.00001)
;;;test fixed-point

(fixed-point cos 1.0);(define tolerance 0.00001)

(define (s-good? a b)
  (< (abs (- a b)) tolerance))
(define tolerance 0.00001)
(load "d:\\sicp\\aux_\\math.ss")
(define (mysqrt x)
  (define (s-try guess)
    (average guess (/ x guess)))
  ;(
   (iter-impro s-good? s-try 1.0) ;1.0)
  )
(mysqrt 9.0);3.0
;;;BEWARE: at first the return value of iter-impro is a procedure, but do like this,
;;;when i define mysqrt i find that it has some faults.if u give it a value, it will
;;;have a error, if don't, it is just a procedure,which make me confused. when i use
;;;the answer in "http://sicp.readthedocs.io/en/latest/chp1/46.html", it shows the
;;;error just like mine, so i make the procedure iter-impro return a value but not a
;;;procedure, which can also work.

;;;answer above:


(define (_sqrt x)
    (define dx 0.00001)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) dx))
    (define (improve guess)
        (average guess (/ x guess)))
    (define (average x y)
        (/ (+ x y) 2))
    ;(
  (iterative-improve close-enough? improve) ;1.0)
  )

(define (iterative-improve close-enough? improve)
    (lambda (first-guess)
        (define (try guess)
            (let ((next (improve guess)))
                (if (close-enough? guess next)
                    next
                    (try next))))
        (try first-guess)))

;;;error: free-identifier=?: expects type <identifier syntax> as 2nd argument, given: #<syntax:39:5 (iterative-improve close-enou...>; other arguments were: #<syntax ~define>