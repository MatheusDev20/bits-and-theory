;; L22

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
(define bar
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

(define (make-counter)
    (let ((global 0))
        (lambda ()
            (let ((local 0))
                (lambda ()
                    (set! local (+ local 1))
                    (set! global (+ global 1))
                    (list local global)
                )
            )
        )
    )
)

;; This would be a class defining class variabels (global)
;; and instance variables (local)
(define make-counter
  (let ((global 0))
    (lambda ()
      (let ((local 0))
        (lambda ()
          (set! local (+ local 1))
          (set! global (+ global 1))
          (list local global)))
    )
          ))

(define counter1 (make-counter)) 
(define counter2 (make-counter))

;; This would be an instances of the "class" that keeps private state (local)
;; and share public state (global)
;; so...

(counter1) ;; (1,1)
(counter1) ;; (1,2)
(counter1) ;; (1,3)
(counter2) ;; (2,4)

;; That happens because global is shared.

;; This all happens because lexical scope and enviroment model
;; Where lambdas can access enviroments of when they where created.







