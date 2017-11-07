open Closure

(* 型のタプルの平坦化 *)
let rec ft = function
  | Type.Fun (ts, t) -> Type.Fun (List.map ft ts, ft t)
  | Type.Tuple ts -> Type.Tuple (List.concat @@ List.map
      (function Type.Tuple ts -> ts | t -> [t]) @@ List.map ft ts)
  | Type.Array t -> Type.Array (ft t)
  | Type.Unit | Type.Bool | Type.Int | Type.Float as t -> t
  | Type.Var _ -> failwith "there still exists Type.Var!"

(* 式のタプルの平坦化 *)
let rec g env (range, ebody) = match ebody with
  | IfEq (range', x, y, e, e') -> range, IfEq (range', x, y, g env e, g env e')
  | IfLT (range', x, y, e, e') -> range, IfLT (range', x, y, g env e, g env e')
  | Let (range', (x, t), e, e') -> range,
      let t' = ft t in
      Let (range', (x, t'), g env e, g (M.add x t' env) e')
  | MakeCls (range', (x, t), cl, e) -> range, MakeCls (range', (x, ft t), cl, g env e)
  | Tuple xs ->
      let f, ys = List.fold_right (fun x (f, ys) -> try
        match M.find x env with
        | Type.Tuple ts ->
            let zts = List.map (fun t -> Id.gentmp (), t) ts in
            (fun e -> range, LetTuple (None, zts, x, f e)), List.map fst zts @ ys
        | _ -> raise Not_found
        with Not_found -> f, x :: ys) xs ((fun e -> e), []) in
      f (range, Tuple ys)
  | LetTuple (range', xts, q, e) ->
      let f, yts, env' = List.fold_right (fun (x, t) (f, yts, env) ->
        let t' = ft t in
        match t' with
        | Type.Tuple ts ->
            let zts = List.map (fun t -> Id.gentmp (), t) ts in
            (fun e -> range, Let (range', (x, t'), (None, Tuple (List.map fst zts)), f e)),
            zts @ yts, M.add x t' env
        | _ -> f, (x, t') :: yts, M.add x t' env) xts ((fun e -> e), [], env) in
      range, LetTuple (range', yts, q, f (g env' e))
  | _ -> range, ebody

(* 関数定義のタプルの平坦化 *)
let h { range = range;
            name = (x, t);
            args = args;
            formal_fv = formal_fv;
            body = body } =
  { range = range;
    name = (x, ft t);
    args = List.map (fun (x, t) -> x, ft t) args;
    formal_fv = List.map (fun (x, t) -> x, ft t) formal_fv;
    body = g M.empty body }

(* プログラムのタプルの平坦化 *)
let f (Prog (fs, e)) =
  Prog (List.map h fs, g M.empty e)
