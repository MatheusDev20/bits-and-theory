
; Define Fibbonaci sequence in terms of "n"

; Fibonnaci sequence

;; 0, 1, 1, 2, 3, 5, 8, 12, 20, 32 55

(define (fibonnaci n )
    (if (< n 2)
        n
        (+ (fibonnaci (- n 1))
           (fibonnaci (- n 2))
        )
    )
)

; Grows exponentially given the input "n" because the multiple recursive call that each (fibbonaci n) generates

