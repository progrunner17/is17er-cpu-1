(* MATSUSHITA: added to t and exp H.range *)
type t = H.range * body
and body =
  | Ans of exp
  | Let of H.range * (Id.t * Type.t) * exp * t (* MATSUSHITA: added H.range *)
and exp = H.range * ebody
and ebody =
  | Nop
  | LI of int
  | FLI of float
  | LIL of Id.l
  | Mv of Id.t
  | Not of Id.t
  | Xor of Id.t * Id.t
  | Neg of Id.t
  | Add of Id.t * Id.t
  | AddI of Id.t * int
  | Sub of Id.t * Id.t
  | SllI of Id.t * int
  | SraI of Id.t * int
  | LW of Id.t * int
  | LWA of Id.t * Id.t
  | SW of Id.t * Id.t * int
  | SWA of Id.t * Id.t * Id.t
  | FMv of Id.t
  | FNeg of Id.t
  | FAbs of Id.t
  | FFloor of Id.t
  | IToF of Id.t
  | FToI of Id.t
  | FSqrt of Id.t
  | FCos of Id.t
  | FSin of Id.t
  | FTan of Id.t
  | FAtan of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | FEq of Id.t * Id.t
  | FLT of Id.t * Id.t
  | FLW of Id.t * int
  | FLWA of Id.t * Id.t
  | FSW of Id.t * Id.t * int
  | FSWA of Id.t * Id.t * Id.t
  | GetC
  | PutC of Id.t
  (* virtual instructions *)
  | IfEq of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | IfLT of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 *)
  | FSave of Id.t * Id.t
  | Restore of Id.t (* スタック変数から値を復元 *)
  | FRestore of Id.t
type fundef = { (* MATSUSHITA: added H.range *) range : H.range; name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }
type prog = Prog of fundef list * t

(* MATSUSHITA: added show_prog function *)
val show_ebody : string array -> H.range -> ebody -> string
val show_prog : string array -> prog -> string

(* MATSUSHITA: added to arguments two H.range's *)
val fletd : H.range * H.range * Id.t * exp * t -> t (* shorthand of Let for float *)
(* MATSUSHITA: added to arguments H.range *)
val seq : H.range * exp * t -> t (* shorthand of Let for unit *)

val regs : Id.t array
val reg_const : int -> Id.t

val fregs : Id.t array
val freg_const : float -> Id.t

val is_reg : Id.t -> bool

val fv : t -> Id.t list
(* MATSUSHITA: added to arguments two H.range's *)
val concat : H.range -> H.range -> t -> Id.t * Type.t -> t -> t
