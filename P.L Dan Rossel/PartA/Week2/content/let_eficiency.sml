(* tl function returns all list elements except the first one *)

val tst = [1, 2, 3]

val tst2 = tl tst

if null (tl tst) then 15 else 16

if (null tl(tst)) then 14 else 15

(* [2,3,4,5]  *)

(* Function to encounter the biggest number of a given list ( Bad way )*)
fun bad_max(xs: int list) =
    if null xs
    then 0
    else if null (tl xs)
    then hd xs
    else if hd xs > bad_max(tl xs)
    then hd xs
    else bad_max(tl xs)


(* [1,2,3,4,5] *)
fun good_max(xs: int list) = 
    if null xs
    then 0

    else if null (tl xs)
    then hd xs

    else
        let val tl_answer = good_max(tl xs)
        in
            if hd xs > tl_answer
            then hd xs
            else tl_answer
        end

val random_list = [1,2,3,4,5,30, 500]
val greater = good_max(random_list)

