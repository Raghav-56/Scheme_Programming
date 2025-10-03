# Quoting in Racket

Racket interprets a word as a variable or function name and outputs/ Displays the value/ evaluation of it.  
To treat it as a literal symbol, you can quote it using a single quote (`'`) or double quotes (`"`).

``` sh
> +
#<procedure:+>
> '+
'+
> "+"
"+"
```

``` sh
> hello
hello: undefined;
 cannot reference an identifier before its definition
  in module: top-level
 [,bt for context]
> 'hello
'hello
> "hello"
"hello"
```
