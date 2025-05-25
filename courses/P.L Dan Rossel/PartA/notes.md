### Shadowing

> Way to change the binding of some variable by creating a "sub enviroment" where this variable will be evaluated when look up happens

```sml
  val a = 5
  val b = 10
  (* Dynamic enviroment where a maps to five and b maps to 10 *)

  val a = 15
  (* Sub Enviroment created where the bindings of b remain the same but the "a" biding was shadowed in the Dynamic enviroment *)

```

### Functions
  > Kind of binding treat as the same way as values ( Hello functional programmers ) it receives an input (...args) and computes something to give a return  

  > They are ?pure? if we have no side effects, same inputs always the same output and also does not depende on any external state  

  > Give us lot of good stuff, like Referential transparency, imutability for concurrent environments and it is easy to reason about the function overall.  

  >Rules of evaluation are quite simple e0(e1,..., en)  

  - >Evaluates e0, the function name doing an lookup in the enviroment to find the binding  
  -  >Evaluates eagerly ( for now ), e1 and en the arguments  
  -  >Extend the enviroment to bind the args to the new valuesand evaluates the body itself, possibily closes over the global enviroment to use any variable if nedded.

```sml 
(* Little example of a pow recursive function *)
  val x = 7
  fun pow(x: int, y: int) = 
      if y=0
      then 1
      else x * pow(x,y-1)

  pow(x, 3) => Cube 
```

### Lists
>Way to build compound data, in SML all lists must be the same type and can be build with the constructor "list" for "[]"

### Let Expressions
> A Way to introduce local bindings and scope and inner enviroments simply defined by
  ```sml 
  let (bindings) in (exp) end
  (* And the whole thing evaluates based on the bindings defined )
  ```
  > Using to define local scope functions and nested functions 
    [Examples](Week2/content/nested_functions.sml);
