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
and v = (t option * string) ref (* MATSUSHITA: added label to type variable *)

let gentyp () = Var (ref (None, Id.genid "'t")) (* 新しい型変数を作る *)

(* MATSUSHITA: added functions *)
let rec show = function
  | Unit -> "unit"
  | Bool -> "bool"
  | Int -> "int"
  | Float -> "float"
  | Fun (ts, t) -> "("^H.sep "" (fun t -> show t^"->") ts^show t^")"
  | Tuple ts -> "("^H.sep "*" show ts^")"
  | Array t -> "["^show t^"]"
  | Var v -> show_v v
  | Forall (vs, t) -> "(@"^H.sep "," show_v vs^"."^show t^")"
and show_v = function
  | {contents = None, l} -> l
  | {contents = Some t, l} -> show t
