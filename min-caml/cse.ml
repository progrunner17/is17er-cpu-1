(* MATSUSHITA: added module Cse *)

open KNormal

module MB =
  Map.Make(
    struct
      type t = body
      let compare = compare
    end)

(* y を y' へと置換する *)
let rec subst y y' (range, body) =
  let q x = if x = y then y' else x in
  match body with
  | Unit | Int _ | Float _ -> range, body
  | Neg x -> range, Neg (q x)
  | Add (x, x') -> range, Add (q x, q x')
  | Sub (x, x') -> range, Sub (q x, q x')
  | FNeg x -> range, FNeg (q x)
  | FAdd (x, x') -> range, FAdd (q x, q x')
  | FSub (x, x') -> range, FSub (q x, q x')
  | FMul (x, x') -> range, FMul (q x, q x')
  | FDiv (x, x') -> range, FDiv (q x, q x')
  | IfEq (range', x, x', e, e') -> range, IfEq (range', q x, q x', subst y y' e, subst y y' e')
  | IfLE (range', x, x', e, e') -> range, IfLE (range', q x, q x', subst y y' e, subst y y' e')
  | Let (range', (x, t), e, e') -> range, Let (range', (x, t), subst y y' e, subst y y' e')
  | Var x -> range, Var (q x)
  | LetRec (range', f, e) -> range, LetRec(range', { f with body = subst y y' f.body }, subst y y' e)
  | App (x, xs) -> range, App (q x, List.map (fun x -> q x) xs)
  | Tuple xs -> range, Tuple (List.map (fun x -> q x) xs)
  | LetTuple (range', xts, x, e) -> range, LetTuple(range', xts, q x, subst y y' e)
  | Get (x, x') -> range, Get (q x, q x')
  | Put (x, x', x'') -> range, Put (q x, q x', q x'')
  | ExtArray x -> range, ExtArray (q x)
  | ExtFunApp (x, xs) -> range, ExtFunApp (q x, List.map (fun x -> q x) xs)

let rec g ffs mb (range, body) = match body with
  | IfEq (range', x, x', e, e') -> range, IfEq (range', x, x', g ffs mb e, g ffs mb e')
  | IfLE (range', x, x', e, e') -> range, IfLE (range', x, x', g ffs mb e, g ffs mb e')
  | Let (range', (x, t), e, e') ->
    if Effect.f ffs e then range, Let (range', (x, t), e, g ffs mb e') else
    if MB.mem (snd e) mb then let x' = MB.find (snd e) mb in g ffs mb (subst x x' e') else
    range, Let (range', (x, t), e, g ffs (MB.add (snd e) x mb) e')
  | LetRec (range', f, e) -> range, LetRec(range', { f with body = g ffs mb f.body }, g ffs mb e)
  | LetTuple (range', xts, x, e) -> range, LetTuple(range', xts, x, g ffs mb e) (* TODO: manipulate mb *)
  | _ -> range, body

let rec f e = g (Effect.get_ffs e) MB.empty e
