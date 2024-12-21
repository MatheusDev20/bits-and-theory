val x = 7


fun pow(x: int, y: int) = 
    if y=0
    then 1
    else x * pow(x,y-1)

val result = pow(5,4)
(*

(* 1 Exec 4 * pow(4,2)) *) pow(4,2) -> Evalutes to 16
(* 2 Exec 4 * pow(4,1)) *) -> pow(4,1) -> Evaluates to 4
(* 3 Exec 4 * pow(4,0)) *) -> pow(4,0) -> Evaluates to 1

*)

fun cube(x: int) = 
    pow(x,3)

val result = cube(4)