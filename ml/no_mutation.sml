fun append(xs: int list, ys: int list) =
    if null xs
    then ys
    else hd (xs) :: append(tl(xs), ys)

val x = [2,4]
val y = [5,3,0]

val z = append(x,y)

(* [2,4,5,3,0] *)
(* the [5,3,0] list in "z" is a Alias to the "y" list, but no worries since we
have no mutation in ML *)