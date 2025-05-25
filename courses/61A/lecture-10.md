# L10 - Sequences.

> Each one has procedures that only work for one type.
> butfirst for example, only work for sentences
> cons, car and cdr only works for list
> follow the data abstraction (list or sequences) that was given

### HOF for lists ( generaling patterns while traversing lists )
>  Every | Keep for sentences
> Map | Filter for lists.

> Reverse 
```scheme
  (define (reverse sent)
  (if (empty ? sent)
  '()
  (se (reverse (butfirst sent)) (first sent))
  ))
```