fun get_list_max(xs: int list) =
    if null xs
    then 0
    else if null (tl xs)
    then hd xs
    else
        let val tl_ans = old_max(tl xs)
        in
            if hd xs > tl_ans
            then hd xs
            else tl_ans
        end

val greater = get_list_max([12,3,4,5,21])

(* option holds a value of some type like INT *)
val some_example = SOME 3 

val get_option_value = valOf some_example

fun get_list_max_with_option(xs: int list) = 
    if null xs
    then NONE
    else
        let val tl_ans = get_list_max_with_option(tl xs)
        in if isSome tl_ans andalso valOf tl_ans > hd xs
        then tl_ans
        else SOME (hd xs)
    end

val greater = get_list_max_with_option([12,3,4,5,61,32])