;; Counts the len of elementes in a list.

; Recursive count
(define (count seq) 
    (if (null? seq))
        0
    (+ 1 (count (cdr seq)))
)
; Each call creates a call stack of recursive calls, the callers keep waiting the response of the recursive call
;; All the information that must be keeped between the recursive calls takes memory
; till the function reach the base case.
; This can cause stack overflow problem and slow the proccess because memory would be more ocupied.

(count (list (1 2 3 4 5 6 7 8 9)))

; Iteration count
(define (count seq)
    (define (iter el result)
        (if (null? el)
            result
            (iter (cdr el) (+ 1 result)) 
        )
    )
    (iter seq 0)
)
;; Each recursive call to iter creates a new update value from the exp (+ 1 result).
;; The whole point is, this way, we dont have to keep track of the recursive calls in order to "unwrape" the values and get the final result back.
;; We dont keep memory ocupied with that.
;; in the last call of iter the value its already returned

(count (list (1 2 3 4 5 6 7 8 9)))