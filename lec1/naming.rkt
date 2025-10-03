#lang racket

(define pi 3.14159)
(print pi)

(define (area-circle r) (* pi r r))
(area-circle 5)

(newline)

(define print_twice (lambda (x)
                      (display x)
                      (newline)
                      (display x)
                      (newline)))

(print_twice "Hello, World!")

(newline)

(define (plural wd) (string-append wd "s"))
(plural "cat")
(plural "fly")

(newline)

(define (plurals wd)
  (if (equal? (string-ref wd (sub1 (string-length wd))) #\y)
    (string-append (substring wd 0 (- (string-length wd) 1)) "ies")
    (string-append wd "s")))

(plurals "fly")
