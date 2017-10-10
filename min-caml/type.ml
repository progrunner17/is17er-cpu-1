type t = (* MinCamlの型を表現するデータ型 (caml2html: type_t) *)
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Array of t
  | Var of t option ref

let gentyp () = Var(ref None) (* 新しい型変数を作る *)

let rec print = function
  | Unit -> print_string "unit"
  | Bool -> print_string "bool"
  | Int -> print_string "int"
  | Float -> print_string "float"
  | Fun (ts, t) -> print_string "("; List.iter (fun t -> print t; print_string "->") ts; print t; print_string ")"
  | Tuple ts -> print_string "("; H.commasep print ts; print_string ")"
  | Array t -> print t; print_string " Array.t"
  | Var rot -> (match !rot with Some t -> print_string "*"; print t; print_string "*" | None -> print_string "*?*")
