(* Programming Languages, Dan Grossman *)
(* Section 3: Lexical Scope and Higher-Order Functions *)

(* first example *)
val x = 1
fun f y = 
    let 
        val x = y+1
    in
        fn z => x + y  + z
    end

val x = 3 (* irrelevant because the defintion of the function "g" will look up the enviroment of the let expression if the function "f" *)
val g = f 4
val y = 5
val z = g 6

(* second example *)
fun f g = 
    let 
        val x = 3
    in
        g 2
    end

val x = 4

fun h y = x + y 

val z = f h
