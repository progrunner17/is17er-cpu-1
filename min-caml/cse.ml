(* MATSUSHITA: added module Cse *)

open KNormal

module MB =
  Map.Make(
    struct
      type t = body
      let compare = compare
    end)

(* プログラムから副作用を持ちうる関数の集合を得る *)
let get_ffs e =
  let ffs = ref S.empty in
  let rec go infs (_, body) = match body with
    | IfEq (_, _, _, e, e') | IfLE (_, _, _, e, e') | Let (_, _, e, e') -> go infs e; go infs e'
    | LetRec (_, { name = x, _; body = e }, e') -> go (S.add x infs) e; go infs e'
    | LetTuple (_, _, _, e) -> go infs e
    | Get _ | Put _ | ExtFunApp _ -> S.iter (fun x -> ffs := S.add x !ffs) infs
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
    if MB.mem (snd e) mb then let x' = MB.find (snd e) mb in g ffs mb (KNormal.subst (M.add x x' M.empty) e') else
    range, Let (range', (x, t), e, g ffs (MB.add (snd e) x mb) e')
  | LetRec (range', f, e) -> range, LetRec(range', { f with body = g ffs mb f.body }, g ffs mb e)
  | LetTuple (range', xts, x, e) -> range, LetTuple(range', xts, x, g ffs mb e) (* TODO: manipulate mb *)
  | _ -> range, body

let rec f e = g (get_ffs e) MB.empty e
