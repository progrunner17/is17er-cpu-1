open KNormal

(* MATSUSHITA: removed function effect *)

let rec g ffs (range, body) = match body with
  | IfEq(range', x, y, e1, e2) -> range, IfEq(range', x, y, g ffs e1, g ffs e2)
  | IfLE(range', x, y, e1, e2) -> range, IfLE(range', x, y, g ffs e1, g ffs e2)
  | Let(range', (x, t), e1, e2) -> (* letの場合 (caml2html: elim_let) *)
      let e1' = g ffs e1 in
      let e2' = g ffs e2 in
      if Effect.f ffs e1' || S.mem x (fv e2') then range, Let(range', (x, t), e1', e2') else
      (Printf.printf "Eliminating variable %s\n" x;
       e2')
  | LetRec(range', { name = (x, t); args = yts; body = e1 }, e2) -> (* let recの場合 (caml2html: elim_letrec) *)
      let e2' = g ffs e2 in
      if S.mem x (fv e2') then
        range, LetRec(range', { name = (x, t); args = yts; body = g ffs e1 }, e2')
      else
        (Printf.printf "Eliminating function %s\n" x;
         e2')
  | LetTuple(range', xts, y, e) ->
      let xs = List.map fst xts in
      let e' = g ffs e in
      let live = fv e' in
      if List.exists (fun x -> S.mem x live) xs then range, LetTuple(range', xts, y, e') else
      (Printf.printf "Eliminating variables %s" (Id.pp_list xs);
       e')
  | _ -> range, body

let f e = g (Effect.get_ffs e) e
