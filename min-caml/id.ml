type t = string (* 変数の名前 (caml2html: id_t) *)
type l = L of string (* トップレベル関数やグローバル配列のラベル (caml2html: id_l) *)

let counter = ref 0
let genid s =
  incr counter;
  let t = try String.sub s 0 (String.rindex s '.') with Not_found -> s in
  Printf.sprintf "%s.%d" t !counter

(* MATSUSHITA: deleted function id_of_typ and added function genunit *)
let genunit () = incr counter; Printf.sprintf "().%d" !counter
let gentmp () = incr counter; Printf.sprintf "tmp.%d" !counter
