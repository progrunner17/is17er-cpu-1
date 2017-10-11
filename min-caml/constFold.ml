open KNormal

let memi x env =
  try (match M.find x env with _, Int(_) -> true | _ -> false)
  with Not_found -> false
let memf x env =
  try (match M.find x env with _, Float(_) -> true | _ -> false)
  with Not_found -> false
let memt x env =
  try (match M.find x env with _, Tuple(_) -> true | _ -> false)
  with Not_found -> false

let findi x env = (match M.find x env with _, Int(i) -> i | _ -> raise Not_found)
let findf x env = (match M.find x env with _, Float(d) -> d | _ -> raise Not_found)
let findt x env = (match M.find x env with _, Tuple(ys) -> ys | _ -> raise Not_found)

let rec g env ((range, body) as e) = match body with (* ������߹��ߥ롼�������� (caml2html: constfold_g) *)
  | Var(x) when memi x env -> range, Int(findi x env)
  | Neg(x) when memi x env -> range, Int(-(findi x env))
  | Add(x, y) when memi x env && memi y env -> range, Int(findi x env + findi y env) (* ­�����Υ����� (caml2html: constfold_add) *)
  | Sub(x, y) when memi x env && memi y env -> range, Int(findi x env - findi y env)
  | FNeg(x) when memf x env -> range, Float(-.(findf x env))
  | FAdd(x, y) when memf x env && memf y env -> range, Float(findf x env +. findf y env)
  | FSub(x, y) when memf x env && memf y env -> range, Float(findf x env -. findf y env)
  | FMul(x, y) when memf x env && memf y env -> range, Float(findf x env *. findf y env)
  | FDiv(x, y) when memf x env && memf y env -> range, Float(findf x env /. findf y env)
  | IfEq(x, y, e1, e2) when memi x env && memi y env -> if findi x env = findi y env then g env e1 else g env e2
  | IfEq(x, y, e1, e2) when memf x env && memf y env -> if findf x env = findf y env then g env e1 else g env e2
  | IfEq(x, y, e1, e2) -> range, IfEq(x, y, g env e1, g env e2)
  | IfLE(x, y, e1, e2) when memi x env && memi y env -> if findi x env <= findi y env then g env e1 else g env e2
  | IfLE(x, y, e1, e2) when memf x env && memf y env -> if findf x env <= findf y env then g env e1 else g env e2
  | IfLE(x, y, e1, e2) -> range, IfLE(x, y, g env e1, g env e2)
  | Let((x, t), e1, e2) -> (* let�Υ����� (caml2html: constfold_let) *)
      let e1' = g env e1 in
      let e2' = g (M.add x e1' env) e2 in
      range, Let((x, t), e1', e2')
  | LetRec({ name = x; args = ys; body = e1 }, e2) ->
      range, LetRec({ name = x; args = ys; body = g env e1 }, g env e2)
  | LetTuple(xts, y, e) when memt y env ->
      List.fold_left2
        (fun e' xt z -> range, Let(xt, (range, Var(z)), e'))
        (g env e)
        xts
        (findt y env)
  | LetTuple(xts, y, e) -> range, LetTuple(xts, y, g env e)
  | _ -> e

let f = g M.empty
