(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* 1 *)
(* string list -> list string *)

fun only_capitals xs = List.filter (fn x => Char.isUpper(String.sub (x, 0))) xs
val result1 = only_capitals(["CapitalLetter", "nonCapitalLetter"])

(* 2 *)
(* Old way *)
fun custom_fold (f,acc,xs) =
    case xs of 
	[] => acc
    | x::xs' => fold (f,f(x, acc),xs')


(* string -> bool *)
fun longest_string xs = List.foldl(fn (str, acc) => if (String.size str > String.size acc) then str else acc) "" xs
(* Using a custom fold function  *)

(* fun longest_string_custom xs = custom_fold( (fn (str, acc) => if (String.size str > String.size acc) then str else acc), "", xs) *)

(* 3 *)
fun longest_string2 xs = List.foldl(fn (str, acc) => if(String.size str >= String.size acc) then str else acc) "" xs
val result = longest_string2 ["ABC", "AFFWEWG", "WFGWGWEGW", "WFGWGWEG2"]

(* 4 *)
fun longest_string_helper f strs = 
	List.foldl (fn (str, acc) =>
					if f(String.size str, String.size acc) then str else acc)  
				"" strs

val longest_string3 = longest_string_helper (fn (len1, len2) => len1 > len2)
val longest_string4 = longest_string_helper (fn (len1, len2 ) => len1 >= len2)

(* Using partial aplication on the curried function longest_string_helper to return a function (closure) that expects a list string *)
val result = longest_string3 ["ABC", "AFFWEWG", "WFGWGWEGW", "WFGWGWEG2"]

(* 5 *)
val longest_string3 = longest_string_helper (fn (len1, len2) => len1 > len2)
fun only_capitals xs = List.filter (fn x => Char.isUpper(String.sub (x, 0))) xs
(* fun compose(f,g) => fn x => f(g x) *)
(* Where g is the function "onlyCapitals" and "f" is the longest_string function *)
val longest_capitalized = longest_string3 o only_capitals
val result = longest_capitalized ["ABC", "eFFWEWG", "tFGWGWEGWgrege", "WFGWGWEG2"]


(* 6 *)
(* NATAL -> LATAN *)
fun reverse_string s = String.implode o rev o String.explode
val t1 = reverse_string "NATAL"



 

