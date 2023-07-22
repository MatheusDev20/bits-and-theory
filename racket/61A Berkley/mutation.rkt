(define a (list "x" "y" "z"))

(define b (cdr a))

;; B = ('y', 'z')
(set-car! b "foo")

;; b = ('foo', 'z')
;; a = ('x', 'foo', 'z')

;; If you do that, you ended up changing the value of A
;; Because the list share memory, pointers to the same pairs.
;; Its a mutation side effect as we already know.
