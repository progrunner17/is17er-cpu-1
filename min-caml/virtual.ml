(* translation into PowerPC assembly with infinite number of virtual registers *)

open Asm

let classify xts ini addf addi =
  List.fold_left
    (fun acc (x, t) ->
      match t with
      | Type.Unit -> acc
      | Type.Float -> addf acc x
      | _ -> addi acc x t)
    ini
    xts

let separate xts =
  classify
    xts
    ([], [])
    (fun (int, float) x -> (int, float @ [x]))
    (fun (int, float) x _ -> (int @ [x], float))

let expand xts ini addf addi =
  classify
    xts
    ini
    (fun (offset, acc) x ->
      (offset + 1, addf x offset acc))
    (fun (offset, acc) x t ->
      (offset + 1, addi x t offset acc))

let rec g env (range, body) = match body with (* 式の仮想マシンコード生成 (caml2html: virtual_g) *)
  | Closure.Unit -> range, Ans(range, Nop)
  | Closure.Int n -> range, Ans(range, LI n)
  | Closure.Float a -> range, Ans(range, FLI a)
  | Closure.Not(x) -> range, Ans(range, Not(x))
  | Closure.Xor(x, y) -> range, Ans(range, Xor(x, y))
  | Closure.Neg(x) -> range, Ans(range, Neg(x))
  | Closure.Add(x, y) -> range, Ans(range, Add(x, y))
  | Closure.Sub(x, y) -> range, Ans(range, Sub(x, y))
  | Closure.SllI(x, n) -> range, Ans(range, SllI(x, n))
  | Closure.SraI(x, n) -> range, Ans(range, SraI(x, n))
  | Closure.AndI(x, n) -> range, Ans(range, AndI(x, n))
  | Closure.FNeg(x) -> range, Ans(range, FNeg(x))
  | Closure.FAbs(x) -> range, Ans(range, FAbs(x))
  | Closure.FFloor(x) -> range, Ans(range, FFloor(x))
  | Closure.IToF(x) -> range, Ans(range, IToF(x))
  | Closure.FToI(x) -> range, Ans(range, FToI(x))
  | Closure.FSqrt(x) -> range, Ans(range, FSqrt(x))
  | Closure.FCos(x) -> range, Ans(range, FCos(x))
  | Closure.FSin(x) -> range, Ans(range, FSin(x))
  | Closure.FTan(x) -> range, Ans(range, FTan(x))
  | Closure.FAtan(x) -> range, Ans(range, FAtan(x))
  | Closure.FAdd(x, y) -> range, Ans(range, FAdd(x, y))
  | Closure.FSub(x, y) -> range, Ans(range, FSub(x, y))
  | Closure.FMul(x, y) -> range, Ans(range, FMul(x, y))
  | Closure.FDiv(x, y) -> range, Ans(range, FDiv(x, y))
  | Closure.FEq(x, y) -> range, Ans(range, FEq(x, y))
  | Closure.FLT(x, y) -> range, Ans(range, FLT(x, y))
  | Closure.IfEq(range', x, y, e1, e2) ->
      range, Ans(range, IfEq(range', x, y, g env e1, g env e2))
  | Closure.IfLT(range', x, y, e1, e2) ->
      range, Ans(range, IfLT(range', x, y, g env e1, g env e2))
  | Closure.Let(range', (x, t1), e1, e2) ->
      let e1' = g env e1 in
      let e2' = g (M.add x t1 env) e2 in
      concat range range' e1' (x, t1) e2'
  | Closure.Var(x) ->
      (match M.find x env with
      | Type.Unit -> range, Ans(range, Nop)
      | Type.Float -> range, Ans(range, FMv(x))
      | _ -> range, Ans(range, Mv(x)))
  | Closure.MakeCls(range', (x, t), { Closure.entry = l; Closure.actual_fv = ys }, e2) -> (* クロージャの生成 (caml2html: virtual_makecls) *)
      (* Closureのアドレスをセットしてから、自由変数の値をストア *)
      let e2' = g (M.add x t env) e2 in
      let offset, store_fv =
        expand
          (List.map (fun y -> (y, M.find y env)) ys)
          (1, e2')
          (fun y offset store_fv -> seq(range, (range', FSW(y, x, offset)), store_fv))
          (fun y _ offset store_fv -> seq(range, (range', SW(y, x, offset)), store_fv)) in
      range, Let(None, (x, t), (range', Mv("%x3")),
        (range, Let(None, ("%x3", Type.Int), (range', AddI("%x3", offset)),
          (range, Let(None, ("%x31", Type.Int), (range', LIL(l)),
            seq(range, (range', SW("%x31", x, 0)),
              store_fv))))))
  | Closure.AppCls(x, ys) ->
      let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
      range, Ans(range, CallCls(x, int, float))
  | Closure.AppDir(Id.L(x), ys) ->
      let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
      range, Ans(range, CallDir(Id.L(x), int, float))
  | Closure.Tuple(xs) -> (* 組の生成 (caml2html: virtual_tuple) *)
      let offset, store =
        expand
          (List.map (fun x -> (x, M.find x env)) xs)
          (0, (range, Ans(range, Mv("%x31"))))
          (fun x offset store -> seq(range, (range, FSW(x, "%x31", offset)), store))
          (fun x _ offset store -> seq(range, (range, SW(x, "%x31", offset)), store))  in
      range, Let(None, ("%x31", Type.Tuple(List.map (fun x -> M.find x env) xs)), (range, Mv("%x3")),
        (range, Let(None, ("%x3", Type.Int), (range, AddI("%x3", offset)),
          store)))
  | Closure.LetTuple(range', xts, y, e2) ->
      let s = Closure.fv e2 in
      let offset, load =
        expand
          xts
          (0, g (M.add_list xts env) e2)
          (fun x offset load ->
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            fletd(range, range', x, (range', FLW(y, offset)), load))
          (fun x t offset load ->
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            range, Let(range', (x, t), (range', LW(y, offset)), load)) in
      load
  | Closure.Array(x, y) -> (match M.find y env with
      | Type.Unit -> range, Ans(range, Nop)
      | Type.Float -> range, Ans(range, FArray(x, y))
      | _ -> range, Ans(range, Array(x, y)))
  | Closure.Get(x, y) -> (match M.find x env with
      | Type.Array(Type.Unit) -> range, Ans(range, Nop)
      | Type.Array(Type.Float) ->
          if !H.boundary_check then
            seq(range, (range, Check(x, y)), (range, Ans(range, FLWA(x, y))))
          else
            range, Ans(range, FLWA(x, y))
      | Type.Array(_) ->
          if !H.boundary_check then
            seq(range, (range, Check(x, y)), (range, Ans(range, LWA(x, y))))
          else
            range, Ans(range, LWA(x, y))
      | _ -> assert false)
  | Closure.Put(x, y, z) -> (match M.find x env with
      | Type.Array(Type.Unit) -> range, Ans(range, Nop)
      | Type.Array(Type.Float) ->
          if !H.boundary_check then
            seq(range, (range, Check(x, y)), (range, Ans(range, FSWA(z, x, y))))
          else
            range, Ans(range, FSWA(z, x, y))
      | Type.Array(_) ->
          if !H.boundary_check then
            seq(range, (range, Check(x, y)), (range, Ans(range, SWA(z, x, y))))
          else
            range, Ans(range, SWA(z, x, y))
      | _ -> assert false)
  | Closure.ExtArray(Id.L(x)) -> range, Ans(range, LIL(Id.L("min_caml_" ^ x)))
  | Closure.Read -> range, Ans(range, Read)
  | Closure.FRead -> range, Ans(range, FRead)
  | Closure.Write x -> range, Ans(range, Write x)

(* 関数の仮想マシンコード生成 (caml2html: virtual_h) *)
let h { Closure.range = range; Closure.name = (Id.L(x), t); Closure.args = yts; Closure.formal_fv = zts; Closure.body = e } =
  let (int, float) = separate yts in
  let (offset, load) =
    expand
      zts
      (1, g (M.add x t (M.add_list yts (M.add_list zts M.empty))) e)
      (fun z offset load -> fletd(range, None, z, (range, FLW(x, offset)), load))
      (fun z t offset load -> range, Let(None, (z, t), (range, LW(x, offset)), load)) in
  match t with
  | Type.Fun(_, t2) ->
      { range = range; name = Id.L(x); args = int; fargs = float; body = load; ret = t2 }
  | _ -> assert false

(* プログラム全体の仮想マシンコード生成 (caml2html: virtual_f) *)
let f (Closure.Prog(fundefs, e)) =
  let fundefs = List.map h fundefs in
  let (range, _) as e = g M.empty e in
  Prog(fundefs,
    (range, Let(None, ("%x3", Type.Int), (None, LI H.heap_start),
      (range, Let(None, ("%x2", Type.Int), (None, LI H.stack_start), e)))))
