datatype 'a option = NONE | SOME of 'a

fun append (xs, ys) = 
    case xs of
        [] => ys
        | x::xs' => x :: append(xs', ys)

(* Where x is the first element of the list and xs' is the tail of the list *)

val result = append(["HI", "THERE", "IM"], ["Matheus", "De", "Paula"])
val result = append([1,2,3], [1,2,3])

val list1 = [1,2,3,4]
val list2 = [5,6,7,8]

val x :: xs = list1
val y :: ys = list2

(* val t =  x :: y  *)
val f = xs @ ys