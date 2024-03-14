;; Substitution Model no longer valid, as we have a new rules of assignment

;Enviroment model is a stack of frames each frame is a table of bindings (variable-value)

; When creating an procedure ( evaluating a lambda expression ) we create two things.
  ;; -> Code, the actual body of the procedure
  ;; -> And a pointer to the enclosing enviroment ( the enviroment in which the procedure was created )

;-> Ok, thats why when evaluating some procedure like
(define square
  (lambda (x) (* x x)))
; I can know the symbol "*" is procedure that is bounded in the global enviroment, so thats why i can use it.

;; So now that the procedure is created, to evalute a new frame is crated Bind the Arguments to the values passed as parameters

(square 5)

;; A New enviroment is created where "x" is bounded to 5 and the body is evaluated given "25" as result


