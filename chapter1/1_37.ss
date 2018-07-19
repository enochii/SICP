;;;both n and d are procedures
(define (cont-frac n d k)
  (define (iter t result)
    (if (= 0 t)
        result
        (iter (- t 1) (/ (n t) (+ result (d t))))))
  (iter (- k 1) (/ (n k) (d k))))
        
;;;recursive version
(define (recur-cont-frac n d k)
  (define (recur step)
    (if (= step k)
        (/ (n k) (d k))
        (/ (n step) (+ (d step) (recur (+ step 1))))))
  (recur 1))

;;:(recur-cont-frac (lambda (i) 1.0)
;;;                 (lambda (i) 1.0)
;;;                  10)
;;;ans = 0.6179775280898876
(define (golden-ratio k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))
(define (golden-ratio)
  (recur-cont-frac (lambda (i) 1.0)
                   (lambda (i) 1.0)
                   10))