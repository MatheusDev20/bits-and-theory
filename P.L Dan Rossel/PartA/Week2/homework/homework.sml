val today = (2022,11,24)
(* 1 *)
fun isOlder(date1: int * int * int, date2: int * int * int) =
    if(#1 date1 < #1 date2)
        then true

    else if(#2 date1 < #2 date2) 
        then true
    
    else if(#3 date1 < #3 date2)
        then true

    else false

val result = isOlder((2022,11,24),(2022,11,24))

(* 2 *)
fun number_of_month(dates: (int * int * int) list, month: int) =
    let
        fun check_month(dates: (int * int * int) list, month: int) =
            if null dates 
            then 0
            else 
                if(#2(hd dates) = month)
                (* If the functions return 1, its because a month was encountered *)
                    then check_month((tl (dates)), month) + 1
                else
                    check_month((tl (dates)), month)
        in
        check_month(dates, month)
    end

val result = number_in_month([(2022,11,24),(2022,11,21),(2022,10,15)],11)

(* 3 *)
fun number_in_months(dates: (int * int * int) list, months: int list) =
    if null months
    then 0
    else number_of_month(dates, hd months) + number_in_months(dates, tl months)

val result = number_in_months([(2022,11,24),(2022,11,21),(2022,10,15), (2022,9,12)],[10,11,9])

(* 4 *),
fun dates_in_month(dates: (int * int * int) list, month: int) = 
    let 
        fun check(dates: (int * int * int) list, month: int) = 
            if null dates
                then []
            else
                if(#2 (hd dates) = month)
                    then
                        hd dates :: check(tl dates, month)
                    else check(tl dates, month)
    in
    check(dates, month)
    end

val result = dates_in_month([(2022,11,24),(2022,11,21),(2022,10,15), (2022,9,12)], 11)

(* 5 *)
fun dates_in_months(dates: (int * int * int) list, months: int list) = 
    let 
        fun append(dates: (int * int * int) list, months: int list) = 
            if null months
            then []
            else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)
    in
    append(dates, months)
    end

val result = dates_in_months([(2022,11,24),(2022,11,21),(2022,10,15), (2022,9,12)], [10,11])

(* 6 *)

fun get_nth(string_list: string list, n: int) = 
    if(n = 1) then hd(string_list)
    else get_nth(tl string_list, n-1)

val result = get_nth(["A", "B", "C", "D"], 2)

(* 7 *)
fun date_to_string(date: int * int * int) =
    let
        val months = ["January", "February", "March", "April",
        "May", "June", "July", "August", "September", "October", "November", "December"]

        fun get_nth(string_list: string list, n: int) = 
            if(n = 1) then hd(string_list)
            else get_nth(tl string_list, n-1)
    in
    get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

val result = date_to_string((2022,11,26))

(* 8 *)
fun number_before_reaching_sum(sum: int, numbers: int list) =
    let
        fun check(sum: int, numbers: int list) =
            if (hd numbers > sum)
            then hd numbers
            else check(sum, tl numbers)

    in
    check(sum, numbers)
    end


fun number_before_reaching_sum (sum : int, posList : int list) =
  if (sum - hd posList) < 1
  then 0
  else 1 + number_before_reaching_sum(sum - hd posList, tl posList)


val result = number_before_reaching_sum(9, [1,2,3,4,5])
(* Primeira chamada number_before_reaching_sum((5, [1,2,3,4,5]) *)
(* Segunda chamada number_before_reaching_sum((4, [2,3,4,5]) *)
(* Terceira chamada number_before_reaching_sum((2,[3,4,5]) *)
