(* Normal recursive function *)

fun fact n = if n=0 then 1 else n * fact(n-1)

(* Tail recursive with accumulator *)
fun fact n = 
    let fun aux(n,acc) =
        if n = 0
        then acc
        else aux(n-1, acc*n)

    in
    aux(n,1)
    end

(* Normal recursive function to sum up elements of a list *)

fun sum xs = 
    case xs of 
        [] =>
        | x::xs' => x + sum xs'

(* Tail recursive version *)
fun sum xs = 
    let fun aux(xs,acc) = 
        case xs of
            [] => acc
            | x::xs' => aux(xs', x+acc)
    
    in
    aux(xs,0)

    end
