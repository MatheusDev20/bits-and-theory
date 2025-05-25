;; Fibonacci Sequence.

;; Bad way to compute, cause we have to compute things like (fib 2) more than once.
(define (fib n)
    (cond ((= n 0) 0 )  
          ((= n 1) 1 ) 
          (else (+ (fib (- n 1)) (fib (- n 2))))
    )
)