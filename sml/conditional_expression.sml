(* Syntax 
    if e1 then e2 else e3
    where if, then and else are keywords
    e1, e2, e3 are subexpressions

   Type Cheking:
    e1 must have the type bool
    e2 and e3 can have any type (t) but they have to be the SAME type (t)
    the type of the entire expression is also (t)

   Evaluation rules:
    first evaluate e1 to a value call it v1 (bool)
    if it's true, evaluate e2 and the result is the whole expression
    if it's false evaluate e3 and the result is the whole expression
*)
val x = 0;
if (3 + 5) > 8 then 12 else 15
val x = 15
