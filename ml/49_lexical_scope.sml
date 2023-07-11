(* Programming Languages, Dan Grossman *)
(* Section 3: Lexical Scope *)

(* 1 *) val x = 1

(* 2 *) fun f y = x + y

(* 3 *) val x = 2

(* 4 *) val y = 3

(* 5 *) val z = f (x + y)

(* In this example, the function "f" adds always 1 to y, because when it was defined the value of x in the enviroment was 1 *)

(* Wherever a function is called, the value of body will look up in the the enviroment where the function was created (x = 1) *)

(* This is what a closure is, a pair of a (body, enviroment) that is created when the function is defined *)

