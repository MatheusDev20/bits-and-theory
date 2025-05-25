(* e1 andalso e2 *)

(* e2 only evaluates if e1 evaluates to true *)
 
val result = (6 > 5) andalso (4 > 6) 
(* result: bool false *)
