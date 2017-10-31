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

let rec g env ((range, body) as e) =
  let zero x env = try findi x env = 0 with Not_found -> false in
  let fzero x env = try findf x env = 0. with Not_found -> false in
  match body with
  | Var(x) when memi x env -> range, Int(findi x env)
  | Not(x) when memi x env -> range, Int(lnot (findi x env))
  | Xor(x, y) when memi x env && memi y env -> range, Int(findi x env lxor findi y env)
  | Neg(x) when memi x env -> range, Int(-(findi x env))
  | Add(x, y) when memi x env && memi y env -> range, Int(findi x env + findi y env)
  | Add(z, x) when zero z env -> range, Var x
  | Add(x, z) when zero z env -> range, Var x
  | Sub(x, y) when memi x env && memi y env -> range, Int(findi x env - findi y env)
  | Sub(x, z) when zero z env -> range, Var x
  | Sub(z, x) when zero z env -> range, Neg x
  | SllI(x, n) when memi x env -> range, Int(findi x env lsl n)
  | SraI(x, n) when memi x env -> range, Int(findi x env asr n)
  | AndI(x, n) when memi x env -> range, Int(findi x env land n)
  | FNeg(x) when memf x env -> range, Float(-.(findf x env))
  | FAbs(x) when memf x env -> range, Float(abs_float (findf x env))
  | FFloor(x) when memf x env -> range, Float(floor (findf x env))
  | IToF(x) when memi x env -> range, Float(float_of_int (findi x env))
  | FToI(x) when memf x env -> range, Int(int_of_float (findf x env))
  | FSqrt(x) when memf x env -> range, Float(sqrt (findf x env))
  | FCos(x) when memf x env -> range, Float(cos (findf x env))
  | FSin(x) when memf x env -> range, Float(sin (findf x env))
  | FTan(x) when memf x env -> range, Float(tan (findf x env))
  | FAtan(x) when memf x env -> range, Float(atan (findf x env))
  | FAdd(x, y) when memf x env && memf y env -> range, Float(findf x env +. findf y env)
  | FAdd(z, x) when fzero z env -> range, Var x
  | FAdd(x, z) when fzero z env -> range, Var x
  | FSub(x, y) when memf x env && memf y env -> range, Float(findf x env -. findf y env)
  | FSub(x, z) when fzero z env -> range, Var x
  | FSub(z, x) when fzero z env -> range, FNeg x
  | FMul(x, y) when memf x env && memf y env -> range, Float(findf x env *. findf y env)
  | FDiv(x, y) when memf x env && memf y env -> range, Float(findf x env /. findf y env)
  | FDiv(x, y) when memf y env -> range,
      let tmp = Id.gentmp () in
      Let(None, (tmp, Type.Float), (range, Float(1. /. findf y env)), (range, FMul(x, tmp)))
  | FEq(x, y) when memf x env && memf y env -> range, Int(if findf x env = findf y env then 1 else 0)
  | FLT(x, y) when memf x env && memf y env -> range, Int(if findf x env < findf y env then 1 else 0)
  | IfEq(_, x, y, e1, e2) when memi x env && memi y env -> if findi x env = findi y env then g env e1 else g env e2
  | IfEq(range', x, y, e1, e2) -> range, IfEq(range', x, y, g env e1, g env e2)
  | IfLT(_, x, y, e1, e2) when memi x env && memi y env -> if findi x env < findi y env then g env e1 else g env e2
  | IfLT(range', x, y, e1, e2) -> range, IfLT(range', x, y, g env e1, g env e2)
  | Let(range', (x, t), e1, e2) -> (* letのケース (caml2html: constfold_let) *)
      let e1' = g env e1 in
      let e2' = g (M.add x e1' env) e2 in
      range, Let(range', (x, t), e1', e2')
  | LetRec(range', { name = x; args = ys; body = e1 }, e2) ->
      range, LetRec(range', { name = x; args = ys; body = g env e1 }, g env e2)
  | LetTuple(range', xts, y, e) when memt y env ->
      List.fold_left2
        (fun e' xt z -> range, Let(range', xt, (range, Var(z)), e'))
        (g env e)
        xts
        (findt y env)
  | LetTuple(range', xts, y, e) -> range, LetTuple(range', xts, y, g env e)
  | _ -> e

let f = g M.empty
