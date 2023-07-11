(* this is a comment, first program in ML*)

val x = 34;
(* static enviroment: x: int *)
(* Dinamyc enviroment: x --> 34 *)

val y = 17;
(* static enviroment: x: int, y: int *)
(* Dynamic enviroment: x --> 34 y--> 17 *)

val z = ( x + y) + ( y + 2 );
(* static enviroment: x: int, y: int, z: int *)
(* Dynamic enviroment: x--> 34, y --> 17, z --> 70 *)

val abs_of_z = if z < 0 then 0 - z else z;
(* Dynamic enviroment: ..., abs_of_z --> 70 *)

val abs_of_z_simpler = abs z;








