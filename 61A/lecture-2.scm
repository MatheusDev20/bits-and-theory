;; Functional programming and Parallelism ? 

;; Aplicative Order ( Eager Evluation )
; Evalutes the sub expression of the procedure before applying it.
(def (zero (- z  z)))

(zero (random 10))
;; Evalutes random 10
(zero 8)
;; And apply 8 to the body of zero
(- 8 8) ==> 0

;; Normal Order ( Lazy Evaluation )
; Evalutes the procedure first and then the sub expression.
(def (zero (- z  z)))

(zero (random 10))
(- (random 10) (random 10))
(random 10) => 8
(random 10) => 1
(- 8 1) => 7

;; Gives the same result as the above example but the order of evaluation is different.

;; Functional programming protects you from side effects, and the order that things are evaluated in does not matter.
;; This is because the functions are pure and do not have side effects.