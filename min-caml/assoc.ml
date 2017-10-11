(* flatten let-bindings (just for prettier printing) *)

open KNormal

let rec f ((range, body) as e) = match body with (* ネストしたletの簡約 (caml2html: assoc_f) *)
  | IfEq(x, y, e1, e2) -> range, IfEq(x, y, f e1, f e2)
  | IfLE(x, y, e1, e2) -> range, IfLE(x, y, f e1, f e2)
  | Let(xt, e1, e2) -> (* letの場合 (caml2html: assoc_let) *)
      let rec insert ((_, body) as e) = match body with
        | Let(yt, e3, e4) -> range, Let(yt, e3, insert e4)
        | LetRec(fundefs, e) -> range, LetRec(fundefs, insert e)
        | LetTuple(yts, z, e) -> range, LetTuple(yts, z, insert e)
        | _ -> range, Let(xt, e, f e2) in
      insert (f e1)
  | LetRec({ name = xt; args = yts; body = e1 }, e2) ->
      range, LetRec({ name = xt; args = yts; body = f e1 }, f e2)
  | LetTuple(xts, y, e) -> range, LetTuple(xts, y, f e)
  | _ -> e
