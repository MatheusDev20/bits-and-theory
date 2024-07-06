(define (make-dog)
  (let ((bark (lambda () "Woof!")))
    (lambda (msg)
      (cond ((eq? msg 'bark) (bark))
            (else "Unknown message")))))

(define my-dog (make-dog))

(display ((my-dog 'bark)))

;; Dispatch a message in Scheme.
