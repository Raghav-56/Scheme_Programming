# how functional programming languages evaluate expressions

## Method 1: Eager Evaluation (also called Applicative Order Evaluation)

1. Evaluate all the sub-expressions i.e. turn actual argument expressions into actual argument values.
2. Give the procedure the actual argument values and evaluate the body of the procedure by substituting the actual argument values for the corresponding formal parameters.

### Parentheses usage (in scheme)

Normal: `(procedure arguments...)`

Exceptions:

- Special forms:
  - `(define var expr)`
  - `(if test then else)`
  - `(cond <clause1> <clause2> ... <else>)` etc. `<clause>` is a pair of expressions: `(test result)`.

eg. Scheme

## Method 2: Normal Order Evaluation (also called Lazy Evaluation)

1. Take actual argument expressions and substitute them for the corresponding formal parameters in the body of the procedure.
2. Evaluation only happens when a primitive is called or when the value of an expression is needed.
3. The outermost function is not applied until its arguments are needed.

eg. Haskell

## Difference

If correct functional programs are used, both always give the same result. However, they may differ in efficiency and termination.

If procedures which are not functional (different answers for same inputs) are used, results may differ.  
Also sometimes normal order evaluation may give a result while eager evaluation may not terminate.
