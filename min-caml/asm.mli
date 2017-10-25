type id_or_imm = V of Id.t | C of int
(* MATSUSHITA: added to t and exp H.range *)
type t = H.range * body
and body =
  | Ans of exp
  | Let of H.range * (Id.t * Type.t) * exp * t (* MATSUSHITA: added H.range *)
and exp = H.range * ebody
and ebody =
  | Nop
  | Li of int
  | FLi of Id.l
  | SetL of Id.l
  | Mr of Id.t
  | Neg of Id.t
  | Add of Id.t * id_or_imm
  | Sub of Id.t * id_or_imm
  | Slw of Id.t * id_or_imm
  | Lwz of Id.t * id_or_imm
  | Stw of Id.t * Id.t * id_or_imm
  | FMr of Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | Lfd of Id.t * id_or_imm
  | Stfd of Id.t * Id.t * id_or_imm
  | Comment of string
  (* virtual instructions *)
  | IfEq of H.range * Id.t * id_or_imm * t * t (* MATSUSHITA: added H.range *)
  | IfLE of H.range * Id.t * id_or_imm * t * t (* MATSUSHITA: added H.range *)
  | IfGE of H.range * Id.t * id_or_imm * t * t (* MATSUSHITA: added H.range *)
  | IfFEq of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | IfFLE of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 *)
  | Restore of Id.t (* スタック変数から値を復元 *)
type fundef = { (* MATSUSHITA: added H.range *) range : H.range; name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }
type prog = Prog of (Id.l * float) list * fundef list * t

(* MATSUSHITA: added show_prog function *)
val show_prog : string array -> prog -> string

(* MATSUSHITA: added to arguments two H.range's *)
val fletd : H.range * H.range * Id.t * exp * t -> t (* shorthand of Let for float *)
(* MATSUSHITA: added to arguments two H.range's *)
val seq : H.range * H.range * exp * t -> t (* shorthand of Let for unit *)

val regs : Id.t array
val fregs : Id.t array
val allregs : Id.t list
val allfregs : Id.t list
val reg_cl : Id.t
val reg_sw : Id.t
val reg_fsw : Id.t
val reg_hp : Id.t
val reg_sp : Id.t
val reg_tmp : Id.t
val is_reg : Id.t -> bool

val fv : t -> Id.t list
(* MATSUSHITA: added to arguments two H.range's *)
val concat : H.range -> H.range -> t -> Id.t * Type.t -> t -> t

val align : int -> int
