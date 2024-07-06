; Scheme interpretor build in Scheme


; REPL
(define (scheme) 
  (print (eval (read)))
  (scheme))

(define (eval exp)
  (cond
    ((self-evaluating? exp) exp)
    ((symbol? exp) (look-up-global-value exp))
    ((special-form? exp) (do-special-form exp))
    ((else (apply (eval (car exp))
              (map eval (cdr exp) )) ))))

(define (apply proc args)
  (if (primitive? proc)
      (do-magic proc args)
      (eval (substitute (body proc (formals proc) args)))))

;; So, what i need to understand here
;; The tree recursion of the eval function, build upon the mutual recurson whre apply
;; calls eval and eval calls apply. This is the core of the interpreter.

;; The point is, scheme expressions are hierarchical, so they generated a strcuture like a
;; tree (AST) and scheme uses recursion to evaluate this tree.