#lang racket

(string-ref "hello" 0)
(first '(h e l l o))

(newline)

(string-ref "hello" 4)
(last '(h e l l o))

(newline)

(list->string (reverse (string->list "hello")))
(length '(h e l l o))
(length (string->list "hello"))

(newline)

(string-append "now" "here")
