;; REPL

(define (calc)
  (display "calc: ")
  (flush)
  (print (calc-eval (read)))
  (calc))


;; Evaluate expression
(define (calc-evel exp)
  (cond ((number? exp) exp)
  ((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
  (else (error "Unknown expression -- CALC-EVAL" exp)))
)

;; Apply function to arguments

(define (calc-apply fn args)
  (cond ((eq? fn '+) (accumulate + 0 args))
        ((eq? fn '-') (cond ((null? args) (error "Calc: no args to '-"))))
                            ((- (length args) 1) (- (car args)))
                            (else (- (car args) (accumulate + 0 (cdr args))))
  (else (error "Calc: BAD OPERATOR"))))