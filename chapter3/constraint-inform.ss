(define (inform-about-value constraint)
  (constraint 'i-have-a-value))
(define (inform-about-no-value constraint)
  (constraint 'i-lost-my-value))