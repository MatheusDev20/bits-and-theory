(* Mapps over a list or any datas structure using a HOF *)
fun my_map (f,xs) = 
    case xs of 
        [] => []
        | x::xs' => (f x)::(my_map(f, xs'))

val mapped = my_map((fn x => x + 1 ), [1,2,3,4,5])

(* Add X to each element of the list *)

(* n is closured by the creation of the anonymus function (fn x => x + n) it encapsulates the enviroment where the fn was created *)
fun add n =
    my_map((fn x => x + n), [1,2,3,4,5])

val addedList = add 5
