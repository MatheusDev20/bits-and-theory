
#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;1 
(define (sequence low high stride)
  (if (> low high)
      (list)
      (cons low (sequence (+ low stride) high stride))))


;2
; w/o racket function "map"
(define (string-append-mad xs suffix)
  (if (null? xs) 
      0
      (cons (string-append (car xs) suffix) (string-append-mad (cdr xs) suffix))))

;with racket map function
(define (string-append-with-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))


;3
(define (list-nth-mod xs number )
  (cond
    [(null? xs) (error "list-nth-mod: empty list" )]
    [(< number 0) (error "list-nth-mod: negative number")]
    [#t (car (list-tail xs (remainder number (length xs) )))]
))

;4
(define (stream-for-n-steps stream number) 
;;; Body

)

;5
(define funny-number-stream
  (letrec ([f (lambda (x)
                (if (= (remainder x 5) 0)
                (cons (- 0 x) (lambda () (f (+ x 1))))   
                (cons x (lambda () (f (+ x 1))))))])
    (lambda () (f 1))))

;6
(define exclude-even-stream
  (letrec ([f (lambda (x)
          (if (= (remainder x 2)) 0)
          (cons "We used to have a Even number Here" (lambda () (f (+ x 1))))
          (cons x (lambda () (f (+ x1 )))))])

    (lambda () (f 1))))

(define (use-my-even-stream even-stream)
  (letrec ([f (lambda) (stream init)
    (let ([stream-pair (stream)])
      (if (car stream-pair ))
    )
  
  ]))

)




