;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;without procedures put and get, codes below cant run -|-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (attach-tag tag x)
  (cons tag x))
(define (type-tag x-with-tag)
  (car x-with-tag))
(define (contents x-with-tag)
  (cdr x-with-tag))
;;for all datas(including scheme-number, rat, complex),
;;we use (<type> . <contents>) to represent it

;;;;;;;;
;;all book code
(define (add x y) (apply-generic 'add x y))
;;....
;;i dont wana define the procedures left, cause it's boring
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  ;;
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)
;;make
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (apply-generic op . args)
  (apply
   (get op (map type-tag args));;return a function
   (contents args)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;internally, datas are without tag, so we can use it conveniently,
;;outside, they have tags so that we can know their type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;rat
(define (install-rational-package)
  (define (number r) (car r))
  (define (denom r) (cdr r))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (number x) (number y))
              (+ (denom x) (denom y))))
  ;;......
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y)
         (tag (add-rat x y))))
  (put 'make 'rational
       (lambda (n d)
         (tag (make-rat n d))))
  'done)
(define (make-rational n d)
  ((get 'make 'rational) n d))
;;complex
(load "d:\\sicp\\chapter2\\complex-system-part.ss")
(define (install-complex-package)
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;;
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part_ z1) (real-part_ z2))
                         (+ (imag-part_ z1) (imag-part_ z2))))
  (put 'real-part '(complex)
       real-part_)
  (put 'imag-part '(complex)
       imag-part_)
  ;;......
  ;;magnitude, angle
  ;;......
  
  ;;here i dont know why it has a error, the code is the same as book code ->
  ;;define: not allowed in an expression context in: (define tag (~lambda (x) (attach-tag (quote complex) x)))
  ;;Environment -> DrScheme, version 4.2.5
  (define (tag x)
    (attach-tag 'complex x))
  (put 'add '(complex complex)
       (lambda (z1 z2)
         (tag (add-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y)
         (tag (make-from-real-imag x y))))
  (put 'mak-from-mag-ang 'complex
       (lambda (r a)
         (tag (make-from-mag-ang r a))))
  'done)
;;
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))