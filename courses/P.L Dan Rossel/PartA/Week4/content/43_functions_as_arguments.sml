(* Programming Languages, Dan Grossman *)
(* Section 3: Functions As Arguments *)

(* it should *pain* us to write the next three functions separately,
   but we do not have to *)
fun increment_n_times_lame (n,x) = (* silly example, this is addition (n+x) *)
   if n=0
   then x
   else 1 + increment_n_times_lame(n-1,x)

fun double_n_times_lame (n,x) = 
   if n=0
   then x
   else 2 * double_n_times_lame(n-1,x)

fun nth_tail_lame (n,xs) =
   if n=0
   then xs
   else tl (nth_tail_lame(n-1,xs))

(* this is much better: as always, abstract the common pieces into a function
   n_times(f,n,x) returns f(f(...(f(x)))) where there are n calls to f
   note: if we gave x type int, then we could not use this for lists
*)
fun n_times (f,n,x) = 
    if n=0
    then x
    else f (n_times(f,n-1,x))


fun increment x = x+1

fun double x = x+x

val x1 = n_times(double,4,7)
val x2 = n_times(increment,4,7)
val x3 = n_times(tl,2,[4,8,12,16]) 

(* and we can define functions that use n_times *)
fun addition (n,x) = n_times(increment,n,x) (* assumes n >=0 *)
fun double_n_times (n,x) = n_times(double,n,x)
fun nth_tail (n,x) = n_times(tl,n,x)

val x5 = addition (2, 5)
(* 1 Exec -> n_times(addition, 1, 5 ) -> Waits the return to the "2 Exec" who is increment(5)
 and apply the high other function to that increment(increment(5)) who is 7, the final Result *)
(* 2 Exec -> n_times(addition, 0, 5) -> Get into the base case and returns X to the High order fn caller increment(5) *)

(* we can then use n_times for more things we did not plan on originally *)

fun triple x = 3*x

fun triple_n_times (n,x) = n_times(triple,n,x)


fun append (xs) = 
   case xs of
   [] =>

(* Function to add an S to a given string *)
fun add_an_S (s) =
  s ^ "S"

fun add_an_P (s) = 
  s ^ "P"

fun increment (s) =   
  s + 1


fun add_letter (f, str) = 
  f(str)

val x1 = add_letter(add_an_S, "ABX")
val x2 = add_letter(add_an_P, "TPD")


