
(* int list -> bool *)
(* Where true means that there is no element in the list smaller thant the element before *)

(* Without nested pattern *)
fun nondecreasing = xs = 
    case xs of
       [] => true
    | x::xs' => case xs' of
                [] => true
                | y::ys' => x <= y andalso nondecreasing xs'


(* With nested pattern *)
fun nondecreasing = xs = 
    case xs of
       [] => true
    | _::[] => true
    (* Where "head" mathces the first element of the list, "neck" the second and "rest" the tail of the list (from the 2th element) *)
    | head:: (neck::rest) => head < neck andalso nondecreasing(neck::rest)


datatype sgn = P | N | Z

fun multisign (x1,x2) = 
    let fun sign x = if x = 0 then Z else if x > 0 then P else N
    in
        case(sign x1, sign x2) of
            (Z,_) => Z
        |   (_,Z) => Z
        |   (P,P) => P
        |    _ => N
    end

(* Lengtg of list using P.M *)

fun len_of_list xs = 
    case xs of
        [] => 0
        |_::xs' => 1 + len xs'
