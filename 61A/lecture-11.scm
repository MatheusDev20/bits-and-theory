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

;; Apply function to argument