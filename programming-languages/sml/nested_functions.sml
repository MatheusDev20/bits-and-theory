
val res1 = count(1, 5)
(* [1,2,3,4,5] *)

fun countup_from1(x: int) =

    let
        fun count(from: int) =
        if from = x
            then x::[]
            else from :: count(from +1)
            (* 1 Exec -> count(1) *)
            (* 2 Exec -> count(2) *)
            (* 3 Exec -> count(3) *)
            (* 4 Exec -> count(4) *)
            (* 5 Exec -> count(5) *)
    in
        count(1)

    end

val res2 = countup_from1(10)