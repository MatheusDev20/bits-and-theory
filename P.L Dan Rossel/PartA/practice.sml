(* Calculates a Lenght of a list using Pattern Matching *)

fun list_len(xs) = 
    case xs of
    [] => 0
    | x::xs' => 1 + list_len xs'

val len = list_len([1,2,3,4,5,6,7,8])

(* Calculate a factorial of a number using Pattern Matching *)

fun factorial n =
    case n of
    0 => 1
    | n => n * factorial(n-1)

val n = factorial 10

(*  *)
