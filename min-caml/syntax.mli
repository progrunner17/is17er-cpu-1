(* MATSUSHITA: added to t H.range *)
type t = H.range * body
and body =
  | Unit
  | Bool of bool
  | Int of int
  | Float of float
  | Not of t
  | Xor of t * t
  | Neg of t
  | Add of t * t
  | Sub of t * t
  | SllI of t * int
  | SraI of t * int
  | AndI of t * int
  | Eq of t * t
  | LT of t * t
  | FNeg of t
  | FAbs of t
  | FFloor of t
  | IToF of t
  | FToI of t
  | FSqrt of t
  | FCos of t
  | FSin of t
  | FTan of t
  | FAtan of t
  | FAdd of t * t
  | FSub of t * t
  | FMul of t * t
  | FDiv of t * t
  | FEq of t * t
  | FLT of t * t
  | If of t * t * t
  | Let of H.range * (Id.t * Type.t) * t * t (* MATSUSHITA: added H.range *)
  | Var of Id.t
  | LetRec of H.range * fundef * t (* MATSUSHITA: added H.range *)
  | GLetRec of H.range * fundefx ref * t (* MATSUSHITA: added GLetRec *)
  | App of t * t list
  | SApp of t * fundefx ref option * Type.t list * t list (* MATSUSHITA: added SApp *)
  | Tuple of t list
  | LetTuple of H.range * (Id.t * Type.t) list * t * t (* MATSUSHITA: added H.range *)
  | Array of t * t
  | Get of t * t
  | Put of t * t * t
  | Read
  | Write of t
  | FRead
  | IFAdd of t * t
  | NotNeg of t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }
and fundefx = fundef * (Type.t list * fundef) list (* MATSUSHITA: added fundefx *)

(* MATSUSHITA: added function show *)
val show : t -> string
