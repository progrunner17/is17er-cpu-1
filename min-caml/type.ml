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

(* MATSUSHITA; added function show *)
let rec show = function
  | Unit -> "unit"
  | Bool -> "bool"
  | Int -> "int"
  | Float -> "float"
  | Fun (ts, t) -> "("^H.sep "" (fun t -> show t^"->") ts^show t^")"
  | Tuple ts -> "("^H.sep "*" show ts^")"
  | Array t -> "["^show t^"]"
  | Var rot -> (match !rot with Some t -> "*"^show t^"*" | None -> "*?*")
