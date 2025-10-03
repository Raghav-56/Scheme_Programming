# naming things

``` sh

> (define pi 3.14159)
> pi
3.14159

```

``` sh

> (define print_twice (lambda (x)
                        (println x)
                        (println x)
                        ))
> (print_twice "hello")
"hello"
"hello"

> (define print_twice (lambda (x) (begin (println x) (println x))))
> (print_twice "hello")
"hello"
"hello"

```
