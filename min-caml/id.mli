type t = string (* 変数の名前 (caml2html: id_t) *)
type l = L of string (* トップレベル関数やグローバル配列のラベル (caml2html: id_l) *)

val counter : int ref
val genid : string -> string

(* MATSUSHITA: deleted function id_of_typ and added function genunit *)
val genunit : unit -> string
val gentmp : unit -> string
