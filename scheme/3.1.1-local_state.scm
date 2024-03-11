;; 3.1 SICP Withdraw example

(withdraw 25)
75

(withdraw 25)
50

(withdraw 60)
"Insufficient funds"

(withdraw 15)
35

;; Same expression exaluates twice with two different arguments
;; The behaviour is not the same, functions cannot be expressed as mathematicals "pure" functions
;; No referential Transparency

;; Implmement withdraw procedure with global enviroment variable "balance"

(define balance 100)

(define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
        balance)
        "Insufficient funds"
    )
)

;; Implement using local binding with let

(define withdraw
    (let ((balance 100))
    (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
            balance)
            "No Funds"
    ))))


(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds")))

(define W1 (make-withdraw 200))
(define W2 (make-withdraw 200))

;; Two independent withdraw objects with the own balamce.
(W1 50) ;; 50
(W1 30) ;; 70

;; Account with a dispatch function, to act inside the local state.
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))))
  dispatch)

(define account1 (make-account 200))
((account1 'withdraw) 50)
;; 150
((account1 'deposit) 100)
;; 250
;; Message passing to call methods that interact with objects private state.

;; Exercise 3.1
(define (make-accumulator initial)
    (lambda (val)
        (begin
        (set! initial (+ initial val))
            initial
        )
    )
)   
;; Exercise 3.2
(define (make-monitored f)
    (define counter 0)
    (define (dispatch message)
        (cond ((eq? message 'how-many-calls) counter)
            ((eq? message 'reset-count) (begin (set! counter 0) counter))
            (else (begin (set! counter (+ counter 1)) (f message)))    
        )
    )
dispatch)

;; Return the dispatch fucntion using a lambda.
(define (make-monitored-better f)
    (let ((calls-counter 0))
        (lambda (message)
           (cond 
                ((eq? message 'how-many-calls) calls-counter)
                ((eq? message 'reset-count) (begin (set! counter 0) calls-counter))
                (else (begin (set! calls-counter (+ calls-counter 1)) (f message)))))))

;; Exercise 3.3
 (define (make-account balance password) 
   (define (withdraw amount) 
     (if (>= balance amount) (begin (set! balance (- balance amount)) balance) 
         "Insufficient funds")) 
   (define (deposit amount)
     (set! balance (+ balance amount)) balance) 
   (define (dispatch p m) 
     (cond ((not (eq? p password)) (lambda (x) "Incorrect password")) 
           ((eq? m 'withdraw) withdraw) 
           ((eq? m 'deposit) deposit)
           (else (error "Unknown request -- MAKE-ACCOUNT" m)))) 
   dispatch)

