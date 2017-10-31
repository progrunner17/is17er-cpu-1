(* MATSUSHITA: added to t H.range *)
type t = H.range * body (* MinCaml�ι�ʸ��ɽ������ǡ����� (caml2html: syntax_t) *)
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
  | App of t * t list
  | Tuple of t list
  | LetTuple of H.range * (Id.t * Type.t) list * t * t (* MATSUSHITA: added H.range *)
  | Array of t * t
  | Get of t * t
  | Put of t * t * t
  | Read
  | Write of t
  | FRead
  | FWrite of t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

(* MATSUSHITA: added function show *)
let rec show (_, body) = match body with
  | Unit -> "()"
  | Bool b -> if b then "true" else "false"
  | Int n -> string_of_int n
  | Float a -> string_of_float a
  | Not e -> "(not "^show e^")"
  | Xor (e, e') -> "(xor "^show e^" "^show e'^")"
  | Neg e -> "(- " ^show e^")"
  | Add (e, e') -> "("^show e^" + "^show e'^")"
  | Sub (e, e') -> "("^show e^" - "^show e'^")"
  | SllI (e, n) -> "("^show e^" sll "^string_of_int n^")"
  | SraI (e, n) -> "("^show e^" sra "^string_of_int n^")"
  | AndI (e, n) -> "(andi "^show e^" "^string_of_int n^")"
  | Eq (e, e') -> "("^show e^" = "^show e'^")"
  | LT (e, e') -> "("^show e^" < "^show e'^")"
  | FNeg e -> "(-. "^show e^")"
  | FAbs e -> "(fabs "^show e^")"
  | FFloor e -> "(ffloor "^show e^")"
  | IToF e -> "(itof "^show e^")"
  | FToI e -> "(ftoi "^show e^")"
  | FSqrt e -> "(fsqrt "^show e^")"
  | FCos e -> "(fcos "^show e^")"
  | FSin e -> "(fsin "^show e^")"
  | FTan e -> "(ftan "^show e^")"
  | FAtan e -> "(fatan "^show e^")"
  | FAdd (e, e') -> "("^show e^" +. "^show e'^")"
  | FSub (e, e') -> "("^show e^" -. "^show e'^")"
  | FMul (e, e') -> "("^show e^" *. "^show e'^")"
  | FDiv (e, e') -> "("^show e^" /. "^show e'^")"
  | FEq (e, e') -> "("^show e^" =. "^show e'^")"
  | FLT (e, e') -> "("^show e^" <. "^show e'^")"
  | If (e, e', e'') -> "(if "^show e^" then "^show e'^" else "^show e''^")"
  | Let (_, (x, t), e, e') -> "(let "^x^":"^Type.show t^" = "^show e^" in "^show e'^")"
  | Var x -> x
  | LetRec (_, f, e) -> "(let rec"^H.sep "" (fun (x, t) -> " ("^x^":"^Type.show t^")") (f.name :: f.args)^" = "^show f.body^" in "^show e^")"
  | App (e, es) -> "("^show e^H.sep "" (fun e -> " "^show e) es^")"
  | Tuple es -> "("^H.sep ", " show es^")"
  | LetTuple (_, xts, e, e') -> "(let ("^H.sep ", " (fun (x, t) -> x^":"^Type.show t) xts^") = "^show e^" in "^show e'^")"
  | Array (e, e') -> "Array.make "^show e^" "^show e'
  | Get (e, e') -> show e^".("^show e'^")"
  | Put (e, e', e'') -> "("^show e^".("^show e'^") <- "^show e''^")"
  | Read -> "read"
  | FRead -> "fread"
  | Write e -> "write "^show e
  | FWrite e -> "fwrite "^show e
