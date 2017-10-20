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

(* プログラムから副作用を持ちうる関数の集合を得る *)
let get_ffs e =
  let ffs = ref S.empty in
  let rec go preffs (_, body) = match body with
    | IfEq (_, _, _, e, e') | IfLE (_, _, _, e, e') | Let (_, _, e, e') -> go preffs e; go preffs e'
    | LetRec (_, { name = x, _; body = e }, e') -> go (S.add x preffs) e; go preffs e'
    | LetTuple (_, _, _, e) -> go preffs e
    | Get _ | Put _ | ExtFunApp _ -> S.iter (fun x -> ffs := S.add x !ffs) preffs
    | _ -> () in
  go S.empty e;
  !ffs

(* 部分式が副作用を持ちうるかどうか *)
let rec effect ffs (_, body) = match body with
  | IfEq (_, _, _, e1, e2) | IfLE (_, _, _, e1, e2) | Let (_, _, e1, e2) -> effect ffs e1 || effect ffs e2
  | Var x -> S.mem x ffs
  | LetRec (_, _, e) | LetTuple (_, _, _, e) -> effect ffs e
  | App (x, xs) -> List.exists (fun x -> S.mem x ffs) (x :: xs)
  | Tuple xs -> List.exists (fun x -> S.mem x ffs) xs
  | Get _ | Put _ | ExtFunApp _ -> true
  | _ -> false

let rec g ffs mb (range, body) = match body with
  | IfEq (range', x, x', e, e') -> range, IfEq (range', x, x', g ffs mb e, g ffs mb e')
  | IfLE (range', x, x', e, e') -> range, IfLE (range', x, x', g ffs mb e, g ffs mb e')
  | Let (range', (x, t), e, e') ->
    if effect ffs e then range, Let (range', (x, t), e, g ffs mb e') else
    if MB.mem (snd e) mb then let x' = MB.find (snd e) mb in g ffs mb (subst x x' e') else
    range, Let (range', (x, t), e, g ffs (MB.add (snd e) x mb) e')
  | LetRec (range', f, e) -> range, LetRec(range', { f with body = g ffs mb f.body }, g ffs mb e)
  | LetTuple (range', xts, x, e) -> range, LetTuple(range', xts, x, g ffs mb e) (* TODO: manipulate mb *)
  | _ -> range, body

let rec f e = g (get_ffs e) MB.empty e
