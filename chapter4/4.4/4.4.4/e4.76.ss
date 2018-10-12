;by comparing value-1 and value-2 which have the common name, return
;a frame or failed symbol
;(load ".\\4.4.4.1.ss")
(define (frame-match value-1 value-2 frame-1 frame-2)
  (cond ((or (eq? frame-1 'failed) (eq? frame-2 'failed)) 
         (cons 'failed 'failed))
        ((equal? value-1 value-2) (cons frame-1 frame-2))
        ((var? value-1)
         (bind-if-possible value-1 value-2 frame-1 frame-2))
        ((var? value-2)
         (bind-if-possible value-2 value-1 frame-2 frame-1))
        ((and (pair? value-1) (pair? value-2))
         (let ((car-result
                (frame-match (car value-1) (car value-2) frame-1 frame-2)))
           (frame-match (cdr value-1) (cdr value-2) (car car-result) (cdr car-result))))
        (else (cons 'failed 'failed))
        ))
;
(define (singleton-frame a-binding)
  (cons a-binding '()))
(define (append-frame f1 f2) (append f1 f2))
;
(define (bind-if-possible var val frame-1 frame-2)
  (let ((binding-1 (binding-in-frame var frame-1))
        (binding-2 (binding-in-frame var frame-2))
        )
    (cond (binding-1
           (frame-match (binding-value binding-1) val frame-1 frame-2))
          (binding-2
           (frame-match (binding-value binding-2) val frame-1 frame-2))
          ((var? val)
           (let ((binding-1 (binding-in-frame val frame-2))
                 (binding-2 (binding-in-frame val frame-1))
                 )
             (if binding-1
                 (frame-match
                  var (binding-value binding-1) frame-1 frame-2)
                 (if binding-2
                     (frame-match
                      var (binding-value binding-2) frame-1 frame-2)
                     (cons (extend var val frame-1) frame-2)))))
          ((depends-on? val var frame-1) 'failed)
          ((depends-on? val var frame-2) 'failed)
          (else (cons (extend var val frame-1) frame-2)))))
;
;(frame-match '(? x) '(? y) '(((? x) 1)) '(((? y) 2)))
;(failed . failed)
;(frame-match '(? x) '(? y) '(((? x) (? z))) '(((? y) 2)))
;((((? z) . 2) ((? x) (? z))) ((? y) 2))
;(frame-match '(? x) '(? y) '(((? x) ((? y) 1))) '(((? y) 2)))
;(failed . failed)
;
;
(define (unify-frame f1 f2)
  (define (iter f1-rest)
    (if (null? f1-rest)
        (cons f1 f2)
        (let ((frame-pair (iter (cdr f1-rest))))
          (if (or (eq? (car frame-pair) 'failed) (eq? (cdr frame-pair) 'failed))
              (cons 'failed 'failed)
              (let* ((binding-1 (car f1-rest))
                     (binding-2 (assoc (binding-variable binding-1) (cdr frame-pair))))
                (if binding-2
                    (frame-match (binding-value binding-1) (binding-value binding-2) (car frame-pair) (cdr frame-pair))
                    frame-pair))))))
        (let ((result (iter f1)))
          (if (or (eq? 'failed (car result)) (eq? 'failed (cdr result)))
              'failed
              (display-and-return
               (combine-frame (car result) (cdr result))))))
;
(define (display-and-return x)
  ;(display x) 
  x)
;
(define (combine-frame f1 f2)
  (define (iter f1-rest)
    (if (null? f1-rest)
        f2
        (if (assoc (binding-variable (car f1-rest)) f2)
            (iter (cdr f1-rest))
            (cons (car f1-rest) (iter (cdr f1-rest))))))
  (iter f1))
;
;(unify-frame '(((? a) (? x)) ((? x) (? z))) '(((? a) (? y))((? y) 2)))
;(unify-frame '(((? x) 1)) '(((? x) 2)))
;(unify-frame '(((? x) 1)) '())
;(unify-frame '() '())
;
(define (new-conjoin conjuncts frame-stream)
  (let ((streams
         (map (lambda (pat) (qeval pat frame-stream)) conjuncts)))
    (define (iter rest-streams)
      (if (stream-null? rest-streams)
          (singleton-stream '())
          (generate-compatible-stream (car rest-streams) (iter (cdr rest-streams)))))
    (iter streams)))
;
;
(define (generate-compatible-stream s1 s2)
  ;(newline)
  ;(display "s1: " )(display-stream s1)(newline)
  ;(display "s2: " )(display-stream s2)(newline)
  (stream-flatmap
   (lambda (frame-1)
     (stream-filter
      (lambda (frame) (not (eq? 'failed frame)))
      (stream-map (lambda (frame) (unify-frame frame-1 frame)) s1)))
   s2))
;change position of s1 and s2 sometimes make answer different...
;here maybe just two stream will work normally

;
;(display-stream (generate-compatible-stream (cons-stream '(((? x) 1)) (singleton-stream '(((? a) (? x)) ((? x) (? z))))) (singleton-stream '())))
(put 'and 'qeval new-conjoin)
;test
;;; Query input
;(and (job ?x (computer programmer)) (supervisor ?y ?x))
;;; Query results
;(and (job (hacker alyssa p) (computer programmer)) (supervisor (reasoner louis) (hacker alyssa p)))
;(unify-frame '(((? person) warbucks oliver) ((? middle-manager) aull dewitt)) '(((? middle-manager) warbucks oliver) ((? x) aull dewitt)))
;
;;; Query input
;(and (supervisor ?middle-manager ?person) (supervisor ?x ?middle-manager))

;;; Query results
;(and (supervisor (scrooge eben) (warbucks oliver)) (supervisor (cratchet robert) (scrooge eben)))
;(and (supervisor (hacker alyssa p) (bitdiddle ben)) (supervisor (reasoner louis) (hacker alyssa p)))
;(and (supervisor (bitdiddle ben) (warbucks oliver)) (supervisor (tweakit lem e) (bitdiddle ben)))
;(and (supervisor (bitdiddle ben) (warbucks oliver)) (supervisor (fect cy d) (bitdiddle ben)))
;(and (supervisor (bitdiddle ben) (warbucks oliver)) (supervisor (hacker alyssa p) (bitdiddle ben)))


;;; Query input
;(and (supervisor ?x ?middle-manager) (supervisor ?middle-manager ?person))

;;; Query results
;(and (supervisor (cratchet robert) (scrooge eben)) (supervisor (scrooge eben) (warbucks oliver)))
;(and (supervisor (tweakit lem e) (bitdiddle ben)) (supervisor (bitdiddle ben) (warbucks oliver)))
;(and (supervisor (reasoner louis) (hacker alyssa p)) (supervisor (hacker alyssa p) (bitdiddle ben)))
;(and (supervisor (fect cy d) (bitdiddle ben)) (supervisor (bitdiddle ben) (warbucks oliver)))
;(and (supervisor (hacker alyssa p) (bitdiddle ben)) (supervisor (bitdiddle ben) (warbucks oliver)))