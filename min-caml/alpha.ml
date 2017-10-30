(* rename identifiers to make them unique (alpha-conversion) *)

open KNormal

let find x env = try M.find x env with Not_found -> x

let rec g env (range, body) = match body with (* α変換ルーチン本体 (caml2html: alpha_g) *)
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
  | Let(range', (x, t), e1, e2) -> (* letのα変換 (caml2html: alpha_let) *)
      let x' = Id.genid x in
      range, Let(range', (x', t), g env e1, g (M.add x x' env) e2)
  | Var(x) -> range, Var(find x env)
  | LetRec(range', { name = (x, t); args = yts; body = e1 }, e2) -> (* let recのα変換 (caml2html: alpha_letrec) *)
      let env = M.add x (Id.genid x) env in
      let ys = List.map fst yts in
      let env' = M.add_list2 ys (List.map Id.genid ys) env in
      range, LetRec(range', { name = (find x env, t);
               args = List.map (fun (y, t) -> (find y env', t)) yts;
               body = g env' e1 },
             g env e2)
  | App(x, ys) -> range, App(find x env, List.map (fun y -> find y env) ys)
  | Tuple(xs) -> range, Tuple(List.map (fun x -> find x env) xs)
  | LetTuple(range', xts, y, e) -> (* LetTupleのα変換 (caml2html: alpha_lettuple) *)
      let xs = List.map fst xts in
      let env' = M.add_list2 xs (List.map Id.genid xs) env in
      range, LetTuple(range', List.map (fun (x, t) -> (find x env', t)) xts,
               find y env,
               g env' e)
  | Get(x, y) -> range, Get(find x env, find y env)
  | Put(x, y, z) -> range, Put(find x env, find y env, find z env)
  | ExtArray(x) -> range, ExtArray(x)
  | ExtFunApp(x, ys) -> range, ExtFunApp(x, List.map (fun y -> find y env) ys)

let f = g M.empty
