type t = (* MinCamlの構文を表現するデータ型 (caml2html: syntax_t) *)
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
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | LetRec of fundef * t
  | App of t * t list
  | Tuple of t list
  | LetTuple of (Id.t * Type.t) list * t * t
  | Array of t * t
  | Get of t * t
  | Put of t * t * t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

let rec print = function
  | Unit -> print_string "()"
  | Bool b -> print_string (if b then "true" else "false")
  | Int n -> print_int n
  | Float a -> print_float a
  | Not e -> print_string "(not "; print e; print_string ")"
  | Neg e -> print_string "(- "; print e; print_string ")"
  | Add (e, e') -> print_string "("; print e; print_string " + "; print e'; print_string ")"
  | Sub (e, e') -> print_string "("; print e; print_string " - "; print e'; print_string ")"
  | FNeg e -> print_string "(-. "; print e; print_string ")"
  | FAdd (e, e') -> print_string "("; print e; print_string " +. "; print e'; print_string ")"
  | FSub (e, e') -> print_string "("; print e; print_string " -. "; print e'; print_string ")"
  | FMul (e, e') -> print_string "("; print e; print_string " *. "; print e'; print_string ")"
  | FDiv (e, e') -> print_string "("; print e; print_string " /. "; print e'; print_string ")"
  | Eq (e, e') -> print_string "("; print e; print_string " = "; print e'; print_string ")"
  | LE (e, e') -> print_string "("; print e; print_string " <= "; print e'; print_string ")"
  | If (e, e', e'') -> print_string "(if "; print e; print_string " then "; print e'; print_string " else "; print e''; print_string ")"
  | Let ((x, t), e, e') -> print_string "(let "; print_string x; print_string ":"; Type.print t; print_string " = "; print e; print_string " in "; print e'; print_string ")"
  | Var x -> print_string x
  | LetRec (f, e) -> print_string "(let rec ("; List.iter (fun (x, t) -> print_string " ("; print_string x; print_string ":"; Type.print t; print_string ")") (f.name :: f.args);
    print_string " = "; print f.body; print_string " in "; print e; print_string ")"
  | App (e, es) -> print_string "("; print e; List.iter (fun e -> print_string " "; print e) es; print_string ")"
  | Tuple es -> print_string "("; H.sep ", " print es; print_string ")"
  | LetTuple (xts, e, e') -> print_string "(let ("; H.sep ", " (fun (x, t) -> print_string x; print_string ":"; Type.print t) xts; print_string ") = "; print e; print_string " in "; print e'; print_string ")"
  | Array (e, e') -> print_string "Array.make "; print e; print_string " "; print e'
  | Get (e, e') -> print e; print_string ".("; print e'; print_string ")"
  | Put (e, e', e'') -> print_string "("; print e; print_string ".("; print e'; print_string ") <- "; print e''; print_string ")"
