# examples of evaluation strategies


# Example 1

``` sh racket

> (define (f a b) (+ (g a) b))
> f a b
> (define (g x) (* 3 x))
> g x

```

### Aplicaitive order

``` sh
(f (+ 2 3) (- 15 6))
    (+ 2 3) => 5
    (- 15 6) => 9
(f 5 9) ---->
(+ (g 5) 9)
    (g 5) ---->
    (* 3 5) => 15
(+ 15 9) => 24
24

```

### Normal order

``` sh
(f (+ 2 3) (- 15 6)) ---->
(+ (g (+ 2 3)) (- 15 6))
    (g (+ 2 3)) ---->
    (* 3 (+ 2 3))
        (+ 2 3) => 5
    (* 3 5) => 15
    (- 15 6) => 9
(+ 15 9) => 24
24

```

## Example 2

``` sh racket
> (define (zero z) (- z z))
zero
```

### Aplicaitive order

``` sh
(zero (random 10))
    (random 10) => some random number, say 7
(zero 7) ---->
(- 7 7) => 0
0
```

### Normal order

``` sh
(zero (random 10)) ---->
(- (random 10) (random 10))
    (random 10) => some random number, say 3
    (random 10) => some random number, say 8
(- 3 8) => -5
-5
```
