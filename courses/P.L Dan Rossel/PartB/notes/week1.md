# Racket Lists
Empty list **null**
Built lists with the constructor **(cons)**
Head of the list with the **(car)**
Access the tail of the list **(cdr)**
Check for empty list **(null?)**
Built in with **(list)** list(e1, e2, en...)
```scheme
(define xs (list 1,2,3,4,5))

(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))
```
Also, build a list with cons cells.
``` scheme
(define my-list (cons 3 (cons 2 (cons 1 '()))))
# list (1,2,3)
(car myList) => 1
(cdr myList) => 3
```


# Parentes Matter.
Using the parenteses syntax and the prefix notation is so much easier to parse the program ( the characters ) to a three data structure

```scheme 
(define cube (lambda (x) (* x x x) ))
``` 
Like this expression turn into to a three where "x" and "x x x" are atoms or "leaves" of this three.


(define (fact n) (if ( = n 0) 1 ( * n (fact ( - n 1 )))))

# Dyamic Typing
The language does not have a Type checker, so errors will happen in runtine, when you try to use some datastructure of function in a wrong way
Like (car "hi"), there is not such thing as (car "hi") because car applys only to lists.

As i know, languages like ML would type check this before it runs, not the case in Racket though.

It is good in some sense, because allow us to do a lot of things, and use the language data structure more freely, but it can lead to runtime errors.


# Cond prefix Racket.
Syntact Sugar to if and elses
```scheme
(cond [exp1 eval1]
      [exp2 eval2]
)
```
only if the expression is true (#t) in racket, the eval part will be evaluated


# Local Bindings.
Three types of local bindings using Racket.

let - different from ML, the value of X will always be the parameter of "x" it does not shadown

```scheme
(define (double1 x)
  (let ([x (+ x 3)]
        [y (+ x 2)])
    (+ x y -5)))
```


let* - Diferent type of binding, the value of previows binding shadow the another ones, the "y" on the list in the following example
assume the value of "2"

```scheme
(let* ([x 1]
         [y (+ x 1)])
    (list y x))

Result -> (2 1)
```


# Mutation in Racket.
You can mutate things in Racket using *(set! e1 exp)* function like following.

*(define b 3)*
*(set ! b 5 )*

So in that enviroment b is binding to the value 5 and any function call that uses this variable will be affected.

** You cannot mutate primitive things like (+) or (*) in Racket with set!, only top level bindings.
```scheme
      (define b 3) 
      (define f (lambda (x) (* 1 (+ x b))))
      (define c (+ b 4)) 
      (set! b 5)
      (define z (f 4))   
      (define w c)    
```

In the follow example, z will be binding to "9", not "7" because when the function f is called, b is muted to the value "5"

# Truth about Cons.
**cons** constructor can also be used to build pairs, in fact using racket lists are nothing more than nested pairs.
```scheme
(define pr (cons 1 (cons #t "hi")))
# this is a pair, not a list, can verified this using *pair?* cons.
(pair? pr) -> #t
```
a *list* is a group of nested pair where the last element of the last pair is the empty list
```scheme
(define lst (cons 1 (cons #t (cons "hi" null))))
# this can be verified by (list? lst) -> Returns true for proper lists and false for inproper lists
```

# Mutable pairs with mCons
In racket, you can't update a Cons Cell like this.
``` scheme
      (define x (cons 42 null)) 
      # x is bounded to the list 42

      (define z x)

      (car x) => 42 
      (car z) => 42

```
z is also binded to this same cons cell, so how can we update the actually cons cell in order to get *(car x)* and *(car z)*
something diferente than 42?

With *mcons* cell
```scheme 
 # defining a mcon sell
 (define cell (mcons 1 (mcons 2 "hi")))

 # now, using the set-mcdr! procedure, we can change the cdr of a cell

 (set-mcdr! cell)
```
# Delayed Evaluation
So, if you dont want to evaluate an expression rigth away, you can "Thunk" this expression.
Thunk an expression means put the expression *e* inside a function with 0 arguments.
Because functions bodys are only evaluate when we call the function, the *e* will not be evaluated till then

``` scheme 
 (+ 3 4)
 # To delay the evaluation of this expression
 lambda () (+ 3 4) 
 
 # Factoryal Example with delayed Eval
 (define (my-if e1 e2 e3)
    (if e1 (e2) (e3)))

(define (factorial-delayed x)
    (my-if ( = x 0 )
           (lambda () 1)
           (lambda () ( * (factorial-delayed ( - x 1))))))

```
Above, *my-if* function evaluates the expresions *e2* and *e3* based on the result of *e1*
this expressions are thunks, lambda functions with 0 arguments, so the evaluation will be delayed till the function is called by *my-if*
To call a thunk and evaluate their body, just wrapped in parenteses like this ( thunk )

This is good, because avoid you to computate this expression on when creating the function.
Most programming languages these days like Java or C use strict evaluation, with is exacly that.

Compute function arguments before creating a function.

``` scheme
      ( (lambda () (+ 5 5)) )
```

# Delay and Force
```scheme 
      ;Example of a computation that takes some time.

      (define (slow-add x y)
            (letrec ([slow-id (lambda (y z)
            (if (= 0 z)
                  y
                  (slow-id y (- z 1))))])
    (+ (slow-id x 50000000) y)))


    (define (my-mult x y-thunk) ;; assumes x is >= 0
        (cond 
            [(= x 0) 0]
            [(= x 1) (y-thunk)]
            [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))

        ;(my-mult 0 (lambda () (slow-add 3 4)))
        ;(my-mult 1 (lambda () (slow-add 3 4)))
        ;(my-mult 2 (lambda () (slow-add 3 4)))

      ; The problem here is because y-thunk is computate on every recursive call of my-mult function.
```   
Delay and force using Promises and *mcons*
```scheme
(define my-delay th)
      (mcons #f th)

(define my-force p)
      (if (mcar p))
            (mcdr p)

      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p)
      )
```

# Streams.
Streams are a program idiom to get infinity values in parts by a consumer.
In Racket, a Stream is a thunk, that when called returns a pair, where the *car* is the first peace of value of that stream
and the *cdr* is the next stream.

``` scheme 
(define (number-until stream tester)
  (letrec ([f (lambda (stream ans)
                (let ([pr (stream)])
                  (if (tester (car pr))
                      ans
                      (f (cdr pr) (+ ans 1)))))])
    (f stream 1)))

(define four (number-until powers-of-two (lambda (x) (= x 16))))

```

# Defining Streams.

```scheme
# Defining a stream that returns a infinity numbers of ones
(define ones (lambda () (cons 1 ones)))

(car ones) => 1
(cdr (ones)) => the procedure itself.

```



