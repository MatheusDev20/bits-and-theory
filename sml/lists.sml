

val x = [1,2,3] 
val y = []

(* tl standard function evaluates to every element on the list except the first *)
val b = tl(x)
(* [2,3] *)

(* hd standard function evaluates to the first list element *)
val c = hd(x)
(* 1 : int *)

(* null standard function returns true if x evaluates to [] *)
null(x)
(* false : bool *)
null(y)
(* true : bool*)


val z = [5,1,6,8]
val firstElOfz = hd(tl(tl(z)))

(* Type Checking *)
(* A List have the type t -> list and can hold only elements of one specific type *)

val listOfIntPairs = [(3,5), (4,5)] 
(* Type (int * int) list *)
val listOfIntegers = [1,3,4,6] 
(* Type int list *)

