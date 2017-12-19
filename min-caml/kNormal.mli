(* MATSUSHITA: added to t H.range *)
type t = H.range * body
and body =
  | Unit
  | Int of int
  | Float of float
  | Not of Id.t
  | Xor of Id.t * Id.t
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | SllI of Id.t * int
  | SraI of Id.t * int
  | AndI of Id.t * int
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
  | IfEq of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | IfLT of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | Let of H.range * (Id.t * Type.t) * t * t (* MATSUSHITA: added H.range *)
  | Var of Id.t
  | LetRec of H.range * fundef * t (* MATSUSHITA: added H.range *)
  | App of Id.t * Id.t list
  | Tuple of Id.t list
  | LetTuple of H.range * (Id.t * Type.t) list * Id.t * t (* MATSUSHITA: added H.range *)
  | Array of Id.t * Id.t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.t
  | ExtFunApp of Id.t * Id.t list
  | Read
  | Write of Id.t
  | FRead
  | FWrite of Id.t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

(* MATSUSHITA: added functions show and subst *)
val show : string array -> t -> string
val subst : Id.t M.t -> t -> t

val fv : t -> S.t
val f : string array -> Syntax.t -> t
