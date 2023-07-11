(* Pairs *)

(* Syntax *)

val pair = (e1, e2)
(* e1 and e2 are separated evaluated to v1 and v2 who compoudn the pair (v1, v2) *)

(* Type checking *)
(* if e1 have type t1 and e2 have type t2 the final Pair will have type (t1 * t2) -> New type *)

fun swap(pr: int * bool) = 
    (#2 pr, #1pr)

(* (int * int) (int * int) -> int *)
fun sum_two_pairs(pr1: int * int, pr2: int * int) =
    (#1 pr1) + (#2 pr1 ) + (#1 pr2) + (#2 pr2)

---------------------------
val x = (3, (4,(5,6)))
(* int *(int * (int * int)) *)
val y = (#2 x, (#1 x,#2(#2 x)))

val ans = (#2 y, 4)
----------------------------

val rPair = (3, 5)
(* int * int *) 

val p = #2 rPair
(* int *)


