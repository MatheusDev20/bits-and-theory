# Lecture 3

> Functions as Data.  

> Functions as First class data types.

```scheme
(define (square-area r) (* r r))  
(define (circle-area r) (* pi r r))
(define (sphere-area r ) (* 4 pi r r))
(define (hexagon-area r)) (* (sqrt 3) 1.5 r r)
```
> Refact to use HOF.
> The idea is to generalize patterns, and abstract in the shape argument, what is different from one to another.

```scheme

(define (get-area shape r) (* shape r r ))

(define square 1)
(define circle pi)
(define sphere (* 4 pi))
(define hexagon (* (sqrt 3) 1.5))
```

> Generalize the Pattern of below functions using a HOF as data.
```scheme
(define (sum-square a b)
  (if (> a b)
    0
    (+ (* a a) (sum-square (+ a 1) b ))))

(define (sum-cube a b)
  (if (> a b)
    0
    (+ (* a a a) (sum-cube (+ a 1) b ))))
```

```scheme
  (define  (sum FN a b)
    (if (> a b)
    0
    (+ (FN a) (sum FN (+ a 1) b))))

  (define (square x)  (* x x ))
  (define (cube x) (* x x x))
```
> Generalizing the pattern in the function "FN" using as data.