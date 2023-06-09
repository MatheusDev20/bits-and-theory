; Eficiency

(define (square x) ( * x x ))


; Takes 6N * 2 N Beingt the size of the sequence sent

(define (squares sent)
    (if (empty? sent)
        '()
        (se (square (first sent))
            (squares (bf sent))
        )
    )
)


; Insert-Sort Algorith with O(n^2) complexity.
(define (sort sent)
    (if (null? sent)
        '()
        (insert (car sent) (sort (cdr sent)))
    )
)

(define (insert num sent)
    (cond ((null? sent) (list num))
          ((< num (car sent)) (cons num sent))
          (else (cons (car sent) (insert num (cdr sent))))
    )
)

(sort (list 5 1 3 4 2))