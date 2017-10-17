(* MATSUSHITA: added module Effect *)

open KNormal

(* プログラムから副作用を持ちうる関数の集合を得る *)
let get_ffs e =
  let ffs = ref S.empty in
  let register preffs xs =
    if List.exists (fun x -> S.mem x !ffs || S.mem x preffs) xs then
      S.iter (fun x -> ffs := S.add x !ffs) preffs in
  let rec go preffs (_, body) = match body with
    | IfEq (_, _, _, e, e') | IfLE (_, _, _, e, e') | Let (_, _, e, e') -> go preffs e; go preffs e'
    | Var x -> register preffs [x]
    | LetRec (_, { name = x, _; body = e }, e') -> go (S.add x preffs) e; go preffs e'
    | App (x, xs) -> register preffs (x :: xs)
    | Tuple xs -> register preffs xs
    | LetTuple (_, _, _, e) -> go preffs e
    | Put _ | ExtFunApp _ -> S.iter (fun x -> ffs := S.add x !ffs) preffs
    | _ -> () in
  go S.empty e;
  !ffs

(* 部分式が副作用を持ちうるかどうか *)
let rec f ffs (_, body) = match body with
  | IfEq (_, _, _, e1, e2) | IfLE (_, _, _, e1, e2) | Let (_, _, e1, e2) -> f ffs e1 || f ffs e2
  | Var x -> S.mem x ffs
  | LetRec (_, _, e) | LetTuple (_, _, _, e) -> f ffs e
  | App (x, xs) -> List.exists (fun x -> S.mem x ffs) (x :: xs)
  | Tuple xs -> List.exists (fun x -> S.mem x ffs) xs
  | Put _ | ExtFunApp _ -> true
  | _ -> false
