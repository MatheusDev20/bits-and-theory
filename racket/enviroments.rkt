;; When a lambda is created, it create two bubbles.

(define foo (lambda (x) (* x x )))
;; Creates in the global enviroment a symbol "foo" that binding to the lambda.

;; The lambda creates two bubbles.
;; 1 - keeps the binding of the parameters and the body
;; 2 - Pointer to the enviroment where the function was created in the case of foo (Global enviroment)

(foo 4) 
;; Now, the invocation creates a new Enviroment to evaluates the body of the function.
;; This new enviroment is enclosured by the global enviroment, so when we do variable look up
;; I Can look up for binding in this "parent" enviroment.
;; Thats why i can evaluate the body of the function using the symbol (*) that binds to procedure in the global enviroment to multiply the args.

;; Lexical scope, is the second bubble, that "remembers" where the function was CREATED instead of INVOKED
;; In contrast of Dynamic Scope.
;; Example:

(define name "Matheus")

(define (bar arg)
    (set! name arg)
)
(define (foo name)
    (bar name)
)
(foo "Nathalia")
> ;; Name evaluates to Nathalia.

;; That happens because lexical scope.
;; the enviroment created by "bar" when the function is Invoked is enclosured by the global enviroment
;; Because it "remebers" where the function was CREATED.




