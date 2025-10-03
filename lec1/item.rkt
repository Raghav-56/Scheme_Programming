#lang racket

(define (item n lst)
  (if (= n 0)
      (car lst)
      (item (- n 1) (cdr lst))))
