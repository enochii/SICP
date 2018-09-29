;;e4.25
;;it will touch off an infinite recursion, in normal order, the code will work well.
;;e4.26
'(unless condition usual-value exceptional-value)
(define (unless? exp)
  (tagged-list? exp 'unless))
(define (unless-precidate exp)
  (cadr exp))
(define (unless-exceptional exp) (cadddr exp))
(define (unless-usual exp) (caddr exp))
;
;;from community.schemewiki.org i see the below code, which confuse me...
;(define select-y '(#t #f #t #t))
;(define xs '(1 3 5 7))
;(define ys '(2 4 6 8))
;(define selected (map unless select-y xs ys))
;
;;derive unless from if
(define (unless->if exp)
  (make-if (unless-predicate exp)
           (unless-exceptional exp)
           (unless-usual exp)))
;;too lazy to test