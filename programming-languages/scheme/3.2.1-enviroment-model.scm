;; Substitution Model no longer valid, as we have a new rules of assignment

;Enviroment model is a stack of frames each frame is a table of bindings (variable-value)

; When creating an procedure ( evaluating a lambda expression ) we create two things.
  ;; -> Code, the actual body of the procedure
  ;; -> And a pointer to the enclosing enviroment ( the enviroment in which the procedure was created )

;-> Ok, thats why when evaluating some procedure like
(define square
  (lambda (x) (* x x)))

; I can know the symbol "*" is a procedure that is bounded in the global enviroment, so thats why i can use it, in some form square has a pointer to the global enviroment

;; So now that the procedure is created, to evalute a new frame is crated Bind the Arguments to the values passed as parameters
(square 5)

;; A New enviroment is created where "x" is bounded to 5 and the body is evaluated given "25" as result

(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

;; Evaluating a code like this, where all procedures are defined in the global enviroment makes 4 enviroments,

;; E1, E2, E3, E4 each enviroment is created when a procedure is called

;; Exercise 3.9 - Determine the enviroment model for the following procedure application
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

RECURSIVE VERSION

global  ________________________
env     | other var.            |
------->| factorial : *         |
        |             |         |
        |_____________|_________|
                      |     ^
                      |     |
                variables : n
                body: (if (= n 1) 1 (* n (factorial (- n 1))))

(factorial 6)

         _______            ^
  E1 -->| n : 6 |___________| GLOBAL
         -------
        (* 6 (factorial 5))
         _______            ^
  E2 -->| n : 5 |___________| GLOBAL
         -------
        (* 5 (factorial 4))
         _______            ^
  E3 -->| n : 4 |___________| GLOBAL
         -------
        (* 4 (factorial 3))
         _______            ^ 
  E4 -->| n : 3 |___________| GLOBAL
         -------
        (* 3 (factorial 2))
         _______            ^
  E5 -->| n : 2 |___________| GLOBAL
         -------
        (* 2 (factorial 1))
         _______            ^
  E6 -->| n : 1 |___________| GLOBAL
         -------
         1

;; Thats why iteration is more space eficient than recursion, because we do not have to keep track of all the enviroments created
;; The normal recursion, we have to keep track of the "STACK" until the last recursive call and the "unwind" of the calls to the original caller.

