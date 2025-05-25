; Eficiency Orders of Growht - Big O Notation


; Constant time => Double the len of the input, double the Running time.
; i.e Take square of a list with N Numbers, when taking with 2N numbers double the runining time.

(define (square x) ( * x x ))

; Takes 6N * 2 N Beingt the size of the sequence sent
(define (squares sequence)
    (if (null? sequence)
        '()
        (cons (square (car sequence))
            (squares (cdr sequence))
        )
    )
)

; Insert-Sort Algorith with O(n^2) complexity.
; Quadratict time = Double the input Quadruples the running time.

(define (insert num sent)
    (cond ((null? sent) (list num))
          ((< num (car sent)) (cons num sent))
          (else (cons (car sent) (insert num (cdr sent))))
    )
)

(define (sort sent)
    (if (null? sent)
        '()
        (insert (car sent) (sort (cdr sent)))
    )
)

(sort (list 5 1 3 4 2))