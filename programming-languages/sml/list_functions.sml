fun sum_list(xs: int list) =
    if null xs
    then 0
    else hd xs + sum_list(tl xs)

val sum = sum_list[1,2,3]


fun countdown (x: int) =
    if x=0
    then []
    else x ::countdown(x-1)

val countdown1 = countdown(8)
(* [8,7,6,5,4,3,2,1] *)

fun append(xs: int list, ys: int list) = 
    if null xs
    then ys
    else (hd xs) :: append((tl,xs), ys)
(* (int list) * (int list) -> int list *)

(* Sum a list of pairs *)
fun sum_pair_list (xs: (int * int) list) = 
    if null xs
    then 0
    else #1 (hd xs) + #2 (hd xs) + sum_pair_list(tl xs)

val result = sum_pair_list([(3,2), (4,5)])
(* 1 Execução na recursão *)
(* else 3 + 2 + sum_pair_list([(4,5)]) * -> Evaluate to 3 + 2 + 9 = 14 *)
(* 2 Execução na recursão *)
(* else 4 + 5 + sum_pair_list([]) * -> Evaluate to 9 *)

fun sum_product_pair_list(xs: (int * int) list) =
    if null xs
    then 0
    else #1 (hd xs) * #2(hd xs) + product_pair_list(tl xs)

val result = sum_product_pair_list([(3,2), (4,5)]) (* Evaluates to 26 *)

(* Return a list with only the first elements of the pairs *)
fun firsts(xs: (int * int) list) = (*[3,5]*)
    if null xs
    then []
    else (#1 (hd xs)) :: firsts(tl xs)

val result = firsts([(3,5), (6,7)])
(* 1 Execução na recursão *)
(* firsts([(3,5), (6,7)]) -> Evaluates to [3] *)

(* 2 Execução na recursão *)
(* firsts([(6,7)]) -> Evaluates to [6] *) 
(* [3] :: [6] -> [3,6] *)

(* Return a list with only the second elements of the pairs *)
fun seconds(xs: (int * int) list) = (*[3,5]*)
    if null xs
    then []
    else (#2 (hd xs)) :: firsts(tl xs)

val result = seconds([(3,5), (6,7)])

(* Return a factorial of a given int N  *)

fun factorial(x: int) = 
    if x=0
    then 1
    else x * factorial(x-1)

val result = factorial(15)
