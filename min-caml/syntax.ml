type t = H.range * body (* MinCamlの構文を表現するデータ型 (caml2html: syntax_t) *)
and body =
  | Unit
  | Bool of bool
  | Int of int
  | Float of float
  | Not of t
  | Neg of t
  | Add of t * t
  | Sub of t * t
  | FNeg of t
  | FAdd of t * t
  | FSub of t * t
  | FMul of t * t
  | FDiv of t * t
  | Eq of t * t
  | LE of t * t
  | If of t * t * t
  | Let of H.range * (Id.t * Type.t) * t * t
  | Var of Id.t
  | LetRec of H.range * fundef * t
  | App of t * t list
  | Tuple of t list
  | LetTuple of H.range * (Id.t * Type.t) list * t * t
  | Array of t * t
  | Get of t * t
  | Put of t * t * t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

let rec show (_, body) = match body with
  | Unit -> "()"
  | Bool b -> if b then "true" else "false"
  | Int n -> string_of_int n
  | Float a -> string_of_float a
  | Not e -> "(not "^show e^")"
  | Neg e -> "(- " ^show e^")"
  | Add (e, e') -> "("^show e^" + "^show e'^")"
  | Sub (e, e') -> "("^show e^" - "^show e'^")"
  | FNeg e -> "(-. "^show e^")"
  | FAdd (e, e') -> "("^show e^" +. "^show e'^")"
  | FSub (e, e') -> "("^show e^" -. "^show e'^")"
  | FMul (e, e') -> "("^show e^" *. "^show e'^")"
  | FDiv (e, e') -> "("^show e^" /. "^show e'^")"
  | Eq (e, e') -> "("^show e^" = "^show e'^")"
  | LE (e, e') -> "("^show e^" <= "^show e'^")"
  | If (e, e', e'') -> "(if "^show e^" then "^show e'^" else "^show e''^")"
  | Let (_, (x, t), e, e') -> "(let "^x^":"^Type.show t^" = "^show e^" in "^show e'^")"
  | Var x -> x
  | LetRec (_, f, e) -> "(let rec ("^H.sep "" (fun (x, t) -> " ("^x^":"^Type.show t^")") (f.name :: f.args)^" = "^show f.body^" in "^show e^")"
  | App (e, es) -> "("^show e^H.sep "" (fun e -> " "^show e) es^")"
  | Tuple es -> "("^H.sep ", " show es^")"
  | LetTuple (_, xts, e, e') -> "(let ("^H.sep ", " (fun (x, t) -> x^":"^Type.show t) xts^") = "^show e^" in "^show e'^")"
  | Array (e, e') -> "Array.make "^show e^" "^show e'
  | Get (e, e') -> show e^".("^show e'^")"
  | Put (e, e', e'') -> "("^show e^".("^show e'^") <- "^show e''^")"
