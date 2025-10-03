#lang racket

(provide buzz)

(define (buzz num) 
    (cond 
        ((equal? (remainder num 7) 0) (print "buzz"))
        ((member 7 num ) (print "buzz"))
        (else print num)))
