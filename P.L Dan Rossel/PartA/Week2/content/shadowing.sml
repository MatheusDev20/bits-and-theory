val a = 10
(* a: int a -> 10 *)

val b = a * 2
(* b: int b -> 20 *)

val a = 5 (* This is not a assigment, this creates another sub enviroment where 
            a is bound to 5 - Shadowing Enviroment *)

(* a: int a -> 5 | b:int b -> 20 *)
val c = b
(* a: int a -> 5 | b:int b -> 20 | c:int b -> 20 *)

val d = a
(* ... | d:int d-> 5 The value of the new enviroment *)


val a = a + 1
(* ... | a:int a-> 6 another dinamic enviroment is created *)

