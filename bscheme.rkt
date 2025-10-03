#lang racket
;; Loader for Berkeley (CS61A-era) Scheme support files.
;; Usage (interactive):
;;   racket -f bscheme.rkt
;; or inside another #lang racket file:
;;   (require "bscheme.rkt") ; provides everything via `provide` forms below
;;
;; This will attempt to load the historical .scm files found under
;; berkeley_cs61a_spring-2011_archive/code/src/ucb/bscheme/
;; and adapt a few minor differences for Racket where practical.

(require racket/runtime-path
         racket/path
         racket/format
         racket/repl
         (only-in r5rs load))

;; Runtime path for the legacy folder relative to repo root.
(define-runtime-path legacy-dir "berkeley_cs61a_spring-2011_archive/code/src/ucb/bscheme")

(define (legacy-path f)
  (define p (build-path legacy-dir f))
  (unless (file-exists? p)
    (error 'bscheme (format "Expected file ~a not found in ~a" f legacy-dir)))
  p)

(define legacy-files '("berkeley.scm" "simply.scm" "explorin.scm" "obj.scm"))

;; Optional graphics file (will fail gracefully if Tk specific code is incompatible).
(define optional-files '("turtle-grfx.scm"))

(define loaded-files '())

(define (load-quiet f)
  (with-handlers ([exn:fail?
                   (lambda (e)
                     (displayln (format "[bscheme] Skipping ~a (~a)" f (exn-message e)))
                     #f)])
    (parameterize ([current-load-relative-directory legacy-dir])
      (load (path->string (legacy-path f)))
      (set! loaded-files (cons f loaded-files))
      #t)))

(for ([f legacy-files]) (load-quiet f))
(for ([f optional-files]) (load-quiet f))

(displayln (format "[bscheme] Loaded files: ~a" (reverse loaded-files)))
(flush-output)

;; Provide a few convenience aliases that often existed in teaching dialects.
;; If they already exist, we avoid redefining.
(define (maybe-alias new existing)
  (when (and (namespace-variable-value existing #t (lambda () #f))
             (not (namespace-variable-value new #t (lambda () #f))))
    (namespace-set-variable-value! new (namespace-variable-value existing))))

;; Common aliases sometimes expected by older code.
(maybe-alias 'first 'car)
(maybe-alias 'rest 'cdr)
(maybe-alias 'nil '())

(provide (all-defined-out))

;; Command-line behavior notes:
;;   racket -f bscheme.rkt          ; loads then exits (no REPL)
;;   racket -it bscheme.rkt         ; loads, then gives a REPL (definitions must be (require)d)
;;   racket -f bscheme.rkt --repl   ; (custom flag) loads then drops into REPL with this module already required

(define cli-args (vector->list (current-command-line-arguments)))

;; Custom --repl flag: after loading, start an interactive REPL with this namespace.
(when (member "--repl" cli-args)
  (displayln "[bscheme] Entering REPL (type ,exit or Ctrl+D to leave).")
  (flush-output)
  (read-eval-print-loop))

;; Legacy placeholder kept for possible future use; --interactive-marker-- no longer needed.
