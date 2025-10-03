#lang racket

(provide pigl)

(define (pigl wd)
    (if (pl-done? wd)
    (string-append wd "ay")
    (pigl (string-append (substring wd 1 (string-length wd)) (string (string-ref wd 0))))))

(define (pl-done? wd)
    (vowel? (string-ref wd 0)))

(define (vowel? letter)
    (member letter '(#\a #\e #\i #\o #\u #\A #\E #\I #\O #\U)))
