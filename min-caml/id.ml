type t = string (* �ѿ���̾�� (caml2html: id_t) *)
type l = L of string (* �ȥåץ�٥�ؿ��䥰���Х�����Υ�٥� (caml2html: id_l) *)

let rec pp_list = function
  | [] -> ""
  | [x] -> x
  | x :: xs -> x ^ " " ^ pp_list xs

let counter = ref 0
let genid s =
  incr counter;
  let t = try String.sub s 0 (String.rindex s '.') with Not_found -> s in
  Printf.sprintf "%s.%d" t !counter

(* MATSUSHITA: deleted id_of_typ and gentmp and added genunit, gentmpint, gentmpfloat and gentmprange *)
let genunit () = incr counter; Printf.sprintf "().%d" !counter
let gentmpint () = genid "tmpint"
let gentmpfloat () = genid "tmpfloat"
let gentmprange range = incr counter; Printf.sprintf "tmp.%s.%d" (H.show_range range) !counter
