;; PitFalls of Imperative programms.

;; Programs that make use of assingement expressions.

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

;; Carol factorial (3)
;; Mark (iter 1 1)
;; Evan (iter 1 2)
;; Theo (iter 2 3)
;; Paul (iter 6 3)  -> Just return the product (6) and thats the result.

;; There is no growth in the call stack like a deep recursion.

;; More imperative style.
(define (factorial n)
  (let ((product 1)
        (counter 1))
    (define (iter)
      (if (> counter n)
          product
          (begin (set! product (* counter 
                                  product))
                 (set! counter (+ counter 1))
                 (iter))))
    (iter)))

;; The order of the assigements matter, because the program has to use the correcto "version"
; of the variables