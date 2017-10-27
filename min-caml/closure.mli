type closure = { entry : Id.l; actual_fv : Id.t list }
(* MATSUSHITA: added to t H.range *)
type t = H.range * body
and body =
  | Unit
  | Int of int
  | Float of float
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | IfEq of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | IfLE of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | Let of H.range * (Id.t * Type.t) * t * t (* MATSUSHITA: added H.range *)
  | Var of Id.t
  | MakeCls of H.range * (Id.t * Type.t) * closure * t (* MATSUSHITA: added H.range *)
  | AppCls of Id.t * Id.t list
  | AppDir of Id.l * Id.t list
  | Tuple of Id.t list
  | LetTuple of H.range * (Id.t * Type.t) list * Id.t * t (* MATSUSHITA: added H.range *)
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.l
type fundef = { range : H.range; (* MATSUSHITA: added H.range *)
                name : Id.l * Type.t;
                args : (Id.t * Type.t) list;
                formal_fv : (Id.t * Type.t) list;
                body : t }
type prog = Prog of fundef list * t

val show_prog : string array -> prog -> string

val fv : t -> S.t
val f : KNormal.t -> prog