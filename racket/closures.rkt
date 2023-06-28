(define (make-count)
    (let ((result 0))
        (lambda ()
        (set! result (+ result 1))
        result
        )))

;; What this actually do, removing the "let" expression.
(define make-count
    (lambda ()
        ((lambda (result)
        (lambda ()
            (set! result (+ result 1))
            result
        ))
        0)))

;; The same thing happen, the outter lambda creates a closure and thats why we can access and KEEP the state "result"
;; so, if i make

(define c1 (make-count))
;; and i called c1 multiple times
(c1) => 1
(c1) => 2

;; the variable result, will keep the value and increment all the way.
;; This happens because the closure created when we called (make-count) can keep state

;; in that way, its kinda similar to the concept of Objects in Oriented Programming, where we can have a state and methods that can change that state

