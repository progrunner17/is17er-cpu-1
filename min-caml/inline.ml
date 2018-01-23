open KNormal

let rec size (_, body) = match body with
  | IfEq(_, _, _, e1, e2) | IfLT(_, _, _, e1, e2)
  | Let(_, _, e1, e2) | LetRec(_, { body = e1 }, e2) -> 1 + size e1 + size e2
  | LetTuple(_, _, _, e) -> 1 + size e
  | _ -> 1

let rec g env ((range, body) as e) = match body with (* ����饤��Ÿ���롼�������� (caml2html: inline_g) *)
  | IfEq(range', x, y, e1, e2) -> range, IfEq(range', x, y, g env e1, g env e2)
  | IfLT(range', x, y, e1, e2) -> range, IfLT(range', x, y, g env e1, g env e2)
  | Let(range', xt, e1, e2) -> range, Let(range', xt, g env e1, g env e2)
  | LetRec(range', { name = (x, t); args = yts; body = e1 }, e2) -> (* �ؿ�����ξ�� (caml2html: inline_letrec) *)
      let env = if size e1 > !H.inline_threshold then env else M.add x (yts, e1) env in
      range, LetRec(range', { name = (x, t); args = yts; body = g env e1}, g env e2)
  | App(x, ys) when M.mem x env -> (* �ؿ�Ŭ�Ѥξ�� (caml2html: inline_app) *)
      let (zs, e) = M.find x env in
      Printf.printf "Inlining %s\n" x;
      let env' =
        List.fold_left2
          (fun env' (z, t) y -> M.add z y env')
          M.empty
          zs
          ys in
      Alpha.g env' e
  | LetTuple(range', xts, y, e) -> range, LetTuple(range', xts, y, g env e)
  | _ -> e

let f e = g M.empty e
