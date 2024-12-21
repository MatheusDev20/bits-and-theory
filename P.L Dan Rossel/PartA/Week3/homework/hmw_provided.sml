(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)

 (* 2 *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove


val card1 = (Clubs, Jack)
val card2 = (Clubs, Queen)
val card3 = (Hearts, Num 3)
val card4 = (Diamonds, Num 5) 
val card5 = (Spades, Ace)

(* A *)
fun select_card_color(c: card) = 
   case c of
   (Clubs, _) => Black
   | (Spades, _) => Black
   | (_, _) => Red

(* Should return Black *)
val card_color_test = select_card_color card3

(* B *)
fun card_value (c: card) = 
   case c of
   (_, Ace) => 11
   | (_, Num x) => x
   | (_, _) => 10

(* Return 11 *)
val card_value_test1 = card_value card1
(* Return 10 *)
val card_value_test2 = card_value card2
(* Return Number "N" *)
val card_value_test3 = card_value card3

(* C *)
fun remove_card (cs: card list, c: card, ex) =
   case cs of
      [] => raise ex
      | hd_c ::cs' => if(hd_c = c)
                      then cs'
                      else hd_c :: remove_card(cs', c, ex)


val selected_card = (Hearts, Num 3)
val remove_card_test = remove_card([card1, card2, card3, card4, card5], selected_card, IllegalMove)

(* D *)
(* card list -> bool *)
fun all_same_color (cs: card list) = 
   case cs of
   [] => false
   | _:: [] => true
   | firstCard::(secondCard :: rest) => select_card_color firstCard = select_card_color secondCard andalso all_same_color(secondCard :: rest)

val same_card_color_list = [(Clubs, Queen), (Hearts, King), (Spades, Ace)]
(* I expect true here tbh *)
val result = all_same_color(same_card_color_list)


(* 1 *)

fun same_string(s1 : string, s2 : string) =
    s1 = s2


fun all_except_option(s, xs) = 
   case xs of 
      [] => NONE
      | x::xs' => 
               if same_string(s, x)
               then SOME xs'
               else case all_except_option(s, xs') of
               NONE => NONE
               | SOME ls => SOME (x:: ls)


val result = all_except_option("TEST", ["MIND",  "CREW", "TEST", "DIVE"])
