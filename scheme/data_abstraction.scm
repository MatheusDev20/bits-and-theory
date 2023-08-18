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

; 2.1.1 SICP Data Abstraction for Rational Numbers

;; A number represented by a numerator and denominator (pair)

(define (make-rat n d)) ;; Constructor for a Data Type Rational
(define (numer x)) ;; Selector for the numerator of a rational number
(define (denom x)) ;; Selector for the denominator of a rational number


(define (add-rational x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rational x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (multiply-rational x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (divide-rational x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rational? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

;; Constructors and Selectors for Rational Numbers Data Type

(define (make-rat n d ) (cons n d))
;; Simplify to the lower terms
(define (make-rat-better n d)  
        (let ((g (gcd n d)))
          (cons (/ n g) (/ d g))))



(define (numer x ) (car x))
(define (denom x) (cdr x))
(define (print-rational x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x))
  )
;; The main idea is to build abstraction barries between these procedures.
;; procedures like add-rational does not have to care at all about how rationals are implemented
;; on the programming language.

;; Its created an Abtractio Barrier between them

;; Exercise 2.2

;; Constrcutor for the ADT Point
(define (make-point x y)
  (cons x y)
)
;; Selectors for the ADT Point
(define (x-point point)
  (car point)
)
(define (y-point point)
  (cdr point)
)
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


;; Each point being a pair
(define (make-segment point1 point2)
  (cons point1 point2)
)

(define (start-segment segment)
  (car segment)
)
(define (end-segment segment)
  (cdr segment)
)
;; midpoint-segment can use the ADT segment, that rely on pointer without know the implementation

(define midpoint-segment segment)
  (let ((start (start-segment segment))
        (end (end-segment segment)))
    (make-point (/ (+ (x-point start) (x-point end)) 2)
                (/ (+ (y-point start) (y-point end)) 2)
    )
  )

;; 2.3
;; Point ADT
(define (make-point x y)
  (cons x y)
)
(define (x-cordinate point)887
  (car x)
)
(define (y-cordinate point)
 (cdr point)
)
(define (make-segment p1 p2)
  (cons p1 p2)
)

(define (start-segment segment)
  (car segment)
)
(define (end-segment segment)
  (cdr segment)
)
