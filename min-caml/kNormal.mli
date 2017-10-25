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
  | LetRec of H.range * fundef * t (* MATSUSHITA: added H.range *)
  | App of Id.t * Id.t list
  | Tuple of Id.t list
  | LetTuple of H.range * (Id.t * Type.t) list * Id.t * t (* MATSUSHITA: added H.range *)
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.t
  | ExtFunApp of Id.t * Id.t list
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

(* MATSUSHITA: added show function *)
val show : string array -> t -> string

val fv : t -> S.t
val f : Syntax.t -> t
