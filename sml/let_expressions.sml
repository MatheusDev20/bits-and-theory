(* let expressions *)
(* Scope bindings *)
fun silly1 (z: int) = 
    (* x and y are only available locally to be use on the body "e" of the let exp *)
    let
        val x = if z < 0 then z else 34
        val y = x + z + 9
    in
        if x > y then x * 2 else y * y

    end

val eval = silly1(3)
(* 46 * 46 *)

fun silly2 () =
    let 
        val x = 1
    in
        (let val x = 2 in x+1 end) + (let val y = x +2 in y+1 end)

    end

val eval = silly2()
(* silly2 evaluates to 7 *)

fun silly3 () =
    let
        val x = (let val x =5 in x + 10 end)
    in
        (x, let val x = 2 in x end, let val x = 10 in let val x = 2 in x end end)

    end
    
val eval = silly3()
(* silly3 evaluates to (15,2,2) *)

