; Abstract Data types:
    ; They are not built into the language, but are implemented in the language itself.
    ; They can be implemented in a programming language like Scheme using Selector and contructor procedures to get their values 

; Example of a "Card" abstract data type.

;; Constructor procedure for creating a card
(define (make-card suit rank)
  (cons suit rank))

;; Selectors for retrieving the suit and rank of a card
(define (card-suit card)
  (car card))

(define (card-rank card)
  (cdr card))