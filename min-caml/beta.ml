open KNormal

let find x env = try M.find x env with Not_found -> x (* 置換のための関数 (caml2html: beta_find) *)

let rec g env (range, body) = match body with (* β簡約ルーチン本体 (caml2html: beta_g) *)
  | Unit -> range, Unit
  | Int(i) -> range, Int(i)
  | Float(d) -> range, Float(d)
  | Neg(x) -> range, Neg(find x env)
  | Add(x, y) -> range, Add(find x env, find y env)
  | Sub(x, y) -> range, Sub(find x env, find y env)
  | FNeg(x) -> range, FNeg(find x env)
  | FAdd(x, y) -> range, FAdd(find x env, find y env)
  | FSub(x, y) -> range, FSub(find x env, find y env)
  | FMul(x, y) -> range, FMul(find x env, find y env)
  | FDiv(x, y) -> range, FDiv(find x env, find y env)
  | IfEq(range', x, y, e1, e2) -> range, IfEq(range', find x env, find y env, g env e1, g env e2)
  | IfLE(range', x, y, e1, e2) -> range, IfLE(range', find x env, find y env, g env e1, g env e2)
  | Let(range', (x, t), e1, e2) -> (* letのβ簡約 (caml2html: beta_let) *)
      (match g env e1 with
      | _, Var(y) ->
          Printf.printf "Beta-reducing %s = %s\n" x y;
          g (M.add x y env) e2
      | e1' ->
          let e2' = g env e2 in
          range, Let(range', (x, t), e1', e2'))
  | LetRec(range', { name = xt; args = yts; body = e1 }, e2) ->
      range, LetRec(range', { name = xt; args = yts; body = g env e1 }, g env e2)
  | Var(x) -> range, Var(find x env) (* 変数を置換 (caml2html: beta_var) *)
  | Tuple(xs) -> range, Tuple(List.map (fun x -> find x env) xs)
  | LetTuple(range', xts, y, e) -> range, LetTuple(range', xts, find y env, g env e)
  | Get(x, y) -> range, Get(find x env, find y env)
  | Put(x, y, z) -> range, Put(find x env, find y env, find z env)
  | App(g, xs) -> range, App(find g env, List.map (fun x -> find x env) xs)
  | ExtArray(x) -> range, ExtArray(x)
  | ExtFunApp(x, ys) -> range, ExtFunApp(x, List.map (fun y -> find y env) ys)

let f = g M.empty
