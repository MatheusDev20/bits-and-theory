(define tree '(1 (2 (4) (5)) (3 (6) (7))))
(define tree (list 1 (list 2 (list 4) (list 5)) (list 3 (list 6) (list 7))))

    1
   / \
  2   3
 / \ / \
4  5 6  7

(define (treemap f t)
  (if (null? t)
      '()
      (cons (f (car t))
            (map (lambda (subtree) (treemap f subtree)) (cdr t)))))

(define (square x) (* x x))

(treemap square tree)

;; Takes a simple list of numbers and return the square using map
(define (map-list f xs)
    (if (null? xs)
        '()
        (cons (f (car xs))
                (map f (cdr xs)))))
