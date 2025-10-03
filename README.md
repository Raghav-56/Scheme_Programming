# Racket: variant of Scheme Programming Language

Lisp family of programming languages.

## Overview

Code stored in `.rkt` files and output in the `.md` files.

The interactive terminal experiments are also shown in `.md` files, particularly for commented out code in `.rkt` files.

## structure

- [X] `lec1/` - First lecture
- [ ] `lec2/` - Second lecture
- [ ] `lec3/` - Third lecture
- [ ] `lec4/` - Fourth lecture
- [ ] `lec5/` - Fifth lecture

...

## Notes

*Found out about "berkeley_cs61a_spring-2011_archive" later on, now using simply-scheme instead of pure racket.

[All the code from lectures etc.](https://people.eecs.berkeley.edu/~bh/61a-pages/)

## Berkeley Scheme Loader

**Did Not Work**

A helper loader `bscheme.rkt` sits at the repo root to pull in the historic CS61A support code located under:
`berkeley_cs61a_spring-2011_archive/code/src/ucb/bscheme/`

It automatically attempts to load these (skipping gracefully if missing/incompatible):
- `berkeley.scm`
- `simply.scm`
- `explorin.scm`
- `obj.scm`
- (optional) `turtle-grfx.scm`

### Quick start (interactive REPL)
```powershell
# From repo root
racket -f bscheme.rkt
```
You will see a line listing loaded files. Then you can evaluate procedures defined therein (e.g., `every`, `keep`, etc.).

### Requiring from another file
In any `#lang racket` file in this repo:
```racket
(require "bscheme.rkt")
(display (map (lambda (x) (* x x)) '(1 2 3 4)))
```

### Non-interactive script including Berkeley support
Create `example.rkt`:
```racket
#lang racket
(require "bscheme.rkt")
(display (every (lambda (x) (+ x 10)) '(1 2 3)))
(newline)
```
Run it:
```powershell
racket example.rkt
```

