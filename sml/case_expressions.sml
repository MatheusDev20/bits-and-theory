datatype mytype = TwoInts of int * int | Str of string | Pizza
(* Here mytype is oneOf kind of type, who define three CONSTRUCTORS to build the type *)


(* Matching the "x" variable with the contrsuctor that x was build with of MyType *)
fun f(x: mytype) = 
    case x of
        Pizza => 3
        | Str s => String.size s
        | TwoInts(i1,i2) => i1 + i2


val result = f(Str("TEST"))

fun f1(x: mytype) = 
    case x of
        Pizza => 3

(* match nonexhaustive error the Str and TwoInts constructos are not inclusde in the pattern matching *)

fun f2(x: mytype) = 
    case x of
        Pizza => 3
        | Str s => String.size s
        | TwoInts(i1,i2) => i1 + i2
        | Pizza => 4

(* Compile Error, the second matching for constructor "Pizza" can never be reached *)