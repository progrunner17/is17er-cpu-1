type t = (* MinCamlの型を表現するデータ型 (caml2html: type_t) *)
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Array of t
  | Var of v
  | Forall of v list * t (* MATSUSHITA: added forall *)
and v = (t option * string) ref

val gentyp : unit -> t

(* MATSUSHITA; added functions *)
val show : t -> string
val show_v : v -> string
