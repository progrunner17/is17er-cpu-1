open KNormal

let rec effect (_, body) = match body with (* 副作用の有無 (caml2html: elim_effect) *)
  | Let(_, _, e1, e2) | IfEq(_, _, _, e1, e2) | IfLE(_, _, _, e1, e2) -> effect e1 || effect e2
  | LetRec(_, _, e) | LetTuple(_, _, _, e) -> effect e
  | App _ | Put _ | ExtFunApp _ -> true
  | _ -> false

let rec f ((range, body) as e) = match body with (* 不要定義削除ルーチン本体 (caml2html: elim_f) *)
  | IfEq(range', x, y, e1, e2) -> range, IfEq(range', x, y, f e1, f e2)
  | IfLE(range', x, y, e1, e2) -> range, IfLE(range', x, y, f e1, f e2)
  | Let(range', (x, t), e1, e2) -> (* letの場合 (caml2html: elim_let) *)
      let e1' = f e1 in
      let e2' = f e2 in
      if effect e1' || S.mem x (fv e2') then range, Let(range', (x, t), e1', e2') else
      (Printf.printf "Eliminating variable %s\n" x;
       e2')
  | LetRec(range', { name = (x, t); args = yts; body = e1 }, e2) -> (* let recの場合 (caml2html: elim_letrec) *)
      let e2' = f e2 in
      if S.mem x (fv e2') then
        range, LetRec(range', { name = (x, t); args = yts; body = f e1 }, e2')
      else
        (Printf.printf "Eliminating function %s\n" x;
         e2')
  | LetTuple(range', xts, y, e) ->
      let xs = List.map fst xts in
      let e' = f e in
      let live = fv e' in
      if List.exists (fun x -> S.mem x live) xs then range, LetTuple(range', xts, y, e') else
      (Printf.printf "Eliminating variables %s" (Id.pp_list xs);
       e')
  | _ -> e
