(* flatten let-bindings (just for prettier printing) *)

open KNormal

let rec f ((range, body) as e) = match body with (* ネストしたletの簡約 (caml2html: assoc_f) *)
  | IfEq(range', x, y, e1, e2) -> range, IfEq(range', x, y, f e1, f e2)
  | IfLT(range', x, y, e1, e2) -> range, IfLT(range', x, y, f e1, f e2)
  | Let(range', xt, e1, e2) -> (* letの場合 (caml2html: assoc_let) *)
      let rec insert ((_, body) as e) = match body with
        | Let(range'', yt, e3, e4) -> range, Let(range'', yt, e3, insert e4)
        | LetRec(range'', fundefs, e) -> range, LetRec(range'', fundefs, insert e)
        | LetTuple(range'', yts, z, e) -> range, LetTuple(range'', yts, z, insert e)
        | _ -> range, Let(range', xt, e, f e2) in
      insert (f e1)
  | LetRec(range', { name = xt; args = yts; body = e1 }, e2) ->
      range, LetRec(range', { name = xt; args = yts; body = f e1 }, f e2)
  | LetTuple(range', xts, y, e) -> range, LetTuple(range', xts, y, f e)
  | _ -> e
