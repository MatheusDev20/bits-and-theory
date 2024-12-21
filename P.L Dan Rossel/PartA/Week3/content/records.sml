val x = {bar=(1+2, true andalso true), foo=3+4, baz=(false,9)}

val my_niece = {name = "Amelia", id=41123 -12}

(* Access each record piece -> #field_name record_name  *)
val name = #id my_niece