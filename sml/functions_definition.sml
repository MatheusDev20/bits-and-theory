(* Syntax Definition in ML *)
fun x0 (x1: t1, ... xn: tn) = e

(* A Function binding is a value *)

(* A Defined function is also a value inside the dinamic enviroment *)

(* A function Evaluates only when its called by the used of () constructor *)

fun randomFn (x: int, y: int) = x + y

(* The arguments passed to are also evaluated before the fn being called *)
(* The arguments are only on the static enviroment for the function (Scope) *)
val result = randomFn((3 * 5), (4 * 5))

(* val result = randomFn(15, 20) *)

(* The type of a function (fn) is defined by the evaluation of this body (e) *)

