datatype mytype = TwoInts of int * int | Str of string | Pizza
(* Here mytype is oneOf kind of type, who define three CONSTRUCTORS to build the type *)

val a = Str "hi"
val b = Str
val c = Pizza
val d = TwoInts(1+2,2+3)
val e = a

(* Evalutes to. *)
(* 
val a = Str "hi" : mytype
val b = fn : string -> mytype
val c = Pizza : mytype
val d = TwoInts (3,5) : mytype
val e = Str "hi" : mytype
 *)

datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int



(* exp -> int *)
fun eval(e: exp ) = 
    case e of
        Constant i => i
        | Negate e2 => ~ (eval e2)
        | Add (e1, e2) => (eval e1) + (eval e2)
        | Multiply(e1, e2) => (eval e1 ) * (eval e2)


(*  *)
val constant_example = eval(Constant 5)
val negate_example = eval(Negate(Constant 4))
val sum_example = eval(Add(Constant 4, Constant 5))
val multiply_example = eval(Multiply(Constant 4, Constant 5))
 

datatype exp = Constant of int | Negate of exp | Add of exp * exp | Multiply of exp * exp

fun max_constant e =
    case e of
        Constant i => i
        | Negate e2 => max_constant e2
        | Add(e1,e2) => Int.max(max_constant e1, max_constant e2 )
        | Multiply(e1,e2) => Int.max(max_constant e1, max_constant e2 )

val test_exp = Add(Constant 19, Negate (Constant 4))
val nineteen = max_constant test_exp