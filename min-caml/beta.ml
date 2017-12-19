open KNormal

let find x env = try M.find x env with Not_found -> x (* 置換のための関数 (caml2html: beta_find) *)

let rec g env (range, body) = match body with (* β簡約ルーチン本体 (caml2html: beta_g) *)
  | Unit -> range, Unit
  | Int(i) -> range, Int(i)
  | Float(d) -> range, Float(d)
  | Not(x) -> range, Not(find x env)
  | Xor(x, y) -> range, Xor(find x env, find y env)
  | Neg(x) -> range, Neg(find x env)
  | Add(x, y) -> range, Add(find x env, find y env)
  | Sub(x, y) -> range, Sub(find x env, find y env)
  | SllI(x, n) -> range, SllI(find x env, n)
  | SraI(x, n) -> range, SraI(find x env, n)
  | AndI(x, n) -> range, AndI(find x env, n)
  | FNeg(x) -> range, FNeg(find x env)
  | FAbs(x) -> range, FAbs(find x env)
  | FFloor(x) -> range, FFloor(find x env)
  | IToF(x) -> range, IToF(find x env)
  | FToI(x) -> range, FToI(find x env)
  | FSqrt(x) -> range, FSqrt(find x env)
  | FCos(x) -> range, FCos(find x env)
  | FSin(x) -> range, FSin(find x env)
  | FTan(x) -> range, FTan(find x env)
  | FAtan(x) -> range, FAtan(find x env)
  | FAdd(x, y) -> range, FAdd(find x env, find y env)
  | FSub(x, y) -> range, FSub(find x env, find y env)
  | FMul(x, y) -> range, FMul(find x env, find y env)
  | FDiv(x, y) -> range, FDiv(find x env, find y env)
  | FEq(x, y) -> range, FEq(find x env, find y env)
  | FLT(x, y) -> range, FLT(find x env, find y env)
  | IfEq(range', x, y, e1, e2) -> range, IfEq(range', find x env, find y env, g env e1, g env e2)
  | IfLT(range', x, y, e1, e2) -> range, IfLT(range', find x env, find y env, g env e1, g env e2)
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
  | Array(x, y) -> range, Array(find x env, find y env)
  | Get(x, y) -> range, Get(find x env, find y env)
  | Put(x, y, z) -> range, Put(find x env, find y env, find z env)
  | App(g, xs) -> range, App(find g env, List.map (fun x -> find x env) xs)
  | ExtArray(x) -> range, ExtArray(x)
  | ExtFunApp(x, ys) -> range, ExtFunApp(x, List.map (fun y -> find y env) ys)
  | Read -> range, Read
  | FRead -> range, FRead
  | Write x -> range, Write (find x env)
  | FWrite x -> range, FWrite (find x env)

let f = g M.empty
