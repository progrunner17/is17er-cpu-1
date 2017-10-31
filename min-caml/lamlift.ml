(* MATSUSHITA: added module Lamlift *)

open KNormal

(* 引数無しの形で式に関数 y が現れるかどうか *)
let rec appear y (_, body) = match body with
  | IfEq(_, _, _, e1, e2) | IfLT(_, _, _, e1, e2)
  | Let(_, _, e1, e2) | LetRec(_, { body = e1 }, e2) -> appear y e1 || appear y e2
  | Var(x) -> x = y
  | App(_, xs) | Tuple(xs) | ExtFunApp(_, xs) -> List.mem y xs
  | LetTuple(_, _, _, e) -> appear y e
  | Put(_, _, x) -> x = y
  | _ -> false

(* 関数呼び出しに自由変数を加える *)
let rec modify y fvs (range, body) = match body with
  | IfEq (range', x, x', e, e') -> range, IfEq (range', x, x', modify y fvs e, modify y fvs e')
  | IfLT (range', x, x', e, e') -> range, IfLT (range', x, x', modify y fvs e, modify y fvs e')
  | Let (range', (x, t), e, e') -> range, Let (range', (x, t), modify y fvs e, modify y fvs e')
  | LetRec (range', ({ body = e } as f), e') ->
      range, LetRec (range', { f with body = modify y fvs e }, modify y fvs e')
  | App (x, xs) -> range, App (x, if x = y then fvs @ xs else xs)
  | LetTuple (range', xts, x, e) -> range, LetTuple(range', xts, x, modify y fvs e)
  | _ -> range, body

(* 自由変数を持つ関数をラムダリフティングし、自由変数を無くす *)
let rec g env known (range, body) = match body with
  | IfEq (range', x, x', e, e') -> range, IfEq (range', x, x', g env known e, g env known e')
  | IfLT (range', x, x', e, e') -> range, IfLT (range', x, x', g env known e, g env known e')
  | Let (range', (x, t), e, e') -> range, Let (range', (x, t), g env known e, g (M.add x t env) known e')
  | LetRec (range', ({ name = (x, t); args = xts; body = e } as f), e') -> range,
      let known = S.add x known in
      if appear x e || appear x e' then
        LetRec (range', { f with body = g (M.add x t env) known e }, g (M.add x t env) known e')
      else
        let fvs = S.elements (S.diff (S.diff (KNormal.fv e) (S.of_list (x :: List.map fst xts))) known) in
        if fvs = [] then
          LetRec (range', { f with body = g (M.add x t env) known e }, g (M.add x t env) known e')
        else
          let _ = Printf.printf "Lambda lifting function %s adding variable%s %s\n"
            x (if List.length fvs = 1 then "" else "s") (String.concat ", " fvs) in
          let fvts = List.map (fun fv -> fv, M.find fv env) fvs in
          let fvfv'ts = List.map (fun (fv, t) -> fv, (Id.genid fv, t)) fvts in
          let fv's = List.map (fun (_, (fv', _)) -> fv') fvfv'ts in
          let env' = List.fold_left (fun acc (fv, (fv', _)) -> M.add fv fv' acc) M.empty fvfv'ts in
          LetRec (range', { f with args = List.map snd fvfv'ts @ f.args;
            body = g (M.add x t env) known (modify x fv's (KNormal.subst env' e)) },
            g (M.add x t env) known (modify x fvs e'))
  | LetTuple (range', xts, x, e) -> range, LetTuple(range', xts, x, g env known e)
  | _ -> range, body

let rec f e = g M.empty S.empty e
