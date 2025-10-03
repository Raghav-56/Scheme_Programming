#lang racket

; Basic arithmetic expression
(+ 23 13 12) ; This should calculates but doesn't print anything to console when run as script
; it seems to be displayed in the console still though that also with newline automatically
; Racket automatically prints the result of any top-level expression (here (+ 23 13 12)), using print plus a newline.
; To suppress the middle 48, wrap the bare expression with void:
(void (+ 23 13 12))

(newline) ; add a newline in the output for clarity

; Print the result of an expression
(display "The sum is: ")
(display (+ 23 13 12))
(newline)

(newline) ; add a newline in the output for clarity

; Printing to console
(display "Hello, Racket!")
(newline) ; need to add after display to move to next line

; Using printf for formatted output, adds newline via ~n
(printf "The result of 23 + 13 + 12 = ~a~n" (+ 23 13 12))

; Print multiple values
(println "This is println - adds newline automatically")
(println (list 1 2 3 4 5))
