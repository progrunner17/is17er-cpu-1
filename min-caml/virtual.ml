(* translation into PowerPC assembly with infinite number of virtual registers *)

open Asm

let data = ref [] (* 浮動小数点数の定数テーブル (caml2html: virtual_data) *)

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
      let offset = align offset in
      (offset + 8, addf x offset acc))
    (fun (offset, acc) x t ->
      (offset + 4, addi x t offset acc))

let rec g env (range, body) = match body with (* 式の仮想マシンコード生成 (caml2html: virtual_g) *)
  | Closure.Unit -> range, Ans(range, Nop)
  | Closure.Int(i) -> range, Ans(range, Li(i))
  | Closure.Float(d) ->
      let l =
        try
          (* すでに定数テーブルにあったら再利用 *)
          let (l, _) = List.find (fun (_, d') -> d = d') !data in
          l
        with Not_found ->
          let l = Id.L(Id.gentmpfloat ()) in
          data := (l, d) :: !data;
          l in
      range, Ans(range, FLi(l))
  | Closure.Neg(x) -> range, Ans(range, Neg(x))
  | Closure.Add(x, y) -> range, Ans(range, Add(x, V(y)))
  | Closure.Sub(x, y) -> range, Ans(range, Sub(x, V(y)))
  | Closure.FNeg(x) -> range, Ans(range, FNeg(x))
  | Closure.FAdd(x, y) -> range, Ans(range, FAdd(x, y))
  | Closure.FSub(x, y) -> range, Ans(range, FSub(x, y))
  | Closure.FMul(x, y) -> range, Ans(range, FMul(x, y))
  | Closure.FDiv(x, y) -> range, Ans(range, FDiv(x, y))
  | Closure.IfEq(range', x, y, e1, e2) ->
      (match M.find x env with
      | Type.Bool | Type.Int -> range, Ans(range, IfEq(range', x, V(y), g env e1, g env e2))
      | Type.Float -> range, Ans(range, IfFEq(range', x, y, g env e1, g env e2))
      | _ -> failwith "equality supported only for bool, int, and float")
  | Closure.IfLE(range', x, y, e1, e2) ->
      (match M.find x env with
      | Type.Bool | Type.Int -> range, Ans(range, IfLE(range', x, V(y), g env e1, g env e2))
      | Type.Float -> range, Ans(range, IfFLE(range', x, y, g env e1, g env e2))
      | _ -> failwith "inequality supported only for bool, int, and float")
  | Closure.Let(range', (x, t1), e1, e2) ->
      let e1' = g env e1 in
      let e2' = g (M.add x t1 env) e2 in
      concat range range' e1' (x, t1) e2'
  | Closure.Var(x) ->
      (match M.find x env with
      | Type.Unit -> range, Ans(range, Nop)
      | Type.Float -> range, Ans(range, FMr(x))
      | _ -> range, Ans(range, Mr(x)))
  | Closure.MakeCls(range', (x, t), { Closure.entry = l; Closure.actual_fv = ys }, e2) -> (* クロージャの生成 (caml2html: virtual_makecls) *)
      (* Closureのアドレスをセットしてから、自由変数の値をストア *)
      let e2' = g (M.add x t env) e2 in
      let offset, store_fv =
        expand
          (List.map (fun y -> (y, M.find y env)) ys)
          (4, e2')
          (fun y offset store_fv -> seq(range, range', (range, Stfd(y, x, C(offset))), store_fv))
          (fun y _ offset store_fv -> seq(range, range', (range, Stw(y, x, C(offset))), store_fv)) in
      range, Let(range', (x, t), (range, Mr(reg_hp)),
          (range, Let(range', (reg_hp, Type.Int), (range, Add(reg_hp, C(align offset))),
              let z = Id.genid "l" in
              (range, Let(range', (z, Type.Int), (range, SetL(l)),
                  seq(range, range', (range, Stw(z, x, C(0))),
                      store_fv))))))
  | Closure.AppCls(x, ys) ->
      let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
      range, Ans(range, CallCls(x, int, float))
  | Closure.AppDir(Id.L(x), ys) ->
      let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
      range, Ans(range, CallDir(Id.L(x), int, float))
  | Closure.Tuple(xs) -> (* 組の生成 (caml2html: virtual_tuple) *)
      let y = Id.genid "t" in
      let (offset, store) =
        expand
          (List.map (fun x -> (x, M.find x env)) xs)
          (0, (range, Ans(range, Mr(y))))
          (fun x offset store -> seq(range, range, (range, Stfd(x, y, C(offset))), store))
          (fun x _ offset store -> seq(range, range, (range, Stw(x, y, C(offset))), store))  in
      range, Let(range, (y, Type.Tuple(List.map (fun x -> M.find x env) xs)), (range, Mr(reg_hp)),
          (range, Let(range, (reg_hp, Type.Int), (range, Add(reg_hp, C(align offset))),
              store)))
  | Closure.LetTuple(range', xts, y, e2) ->
      let s = Closure.fv e2 in
      let (offset, load) =
        expand
          xts
          (0, g (M.add_list xts env) e2)
          (fun x offset load ->
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            fletd(range, range', x, (range, Lfd(y, C(offset))), load))
          (fun x t offset load ->
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            range, Let(range, (x, t), (range, Lwz(y, C(offset))), load)) in
      load
  | Closure.Get(x, y) -> (* 配列の読み出し (caml2html: virtual_get) *)
      let offset = Id.genid "o" in
      (match M.find x env with
      | Type.Array(Type.Unit) -> range, Ans(range, Nop)
      | Type.Array(Type.Float) ->
          range, Let(range, (offset, Type.Int), (range, Slw(y, C(3))),
              (range, Ans(range, Lfd(x, V(offset)))))
      | Type.Array(_) ->
          range, Let(range, (offset, Type.Int), (range, Slw(y, C(2))),
              (range, Ans(range, Lwz(x, V(offset)))))
      | _ -> assert false)
  | Closure.Put(x, y, z) ->
      let offset = Id.genid "o" in
      (match M.find x env with
      | Type.Array(Type.Unit) -> range, Ans(range, Nop)
      | Type.Array(Type.Float) ->
          range, Let(range, (offset, Type.Int), (range, Slw(y, C(3))),
              (range, Ans(range, Stfd(z, x, V(offset)))))
      | Type.Array(_) ->
          range, Let(range, (offset, Type.Int), (range, Slw(y, C(2))),
              (range, Ans(range, Stw(z, x, V(offset)))))
      | _ -> assert false)
  | Closure.ExtArray(Id.L(x)) -> range, Ans(range, SetL(Id.L("min_caml_" ^ x)))

(* 関数の仮想マシンコード生成 (caml2html: virtual_h) *)
let h { Closure.range = range; Closure.name = (Id.L(x), t); Closure.args = yts; Closure.formal_fv = zts; Closure.body = e } =
  let (int, float) = separate yts in
  let (offset, load) =
    expand
      zts
      (4, g (M.add x t (M.add_list yts (M.add_list zts M.empty))) e)
      (fun z offset load -> fletd(range, range, z, (range, Lfd(x, C(offset))), load))
      (fun z t offset load -> range, Let(range, (z, t), (range, Lwz(x, C(offset))), load)) in
  match t with
  | Type.Fun(_, t2) ->
      { range = range; name = Id.L(x); args = int; fargs = float; body = load; ret = t2 }
  | _ -> assert false

(* プログラム全体の仮想マシンコード生成 (caml2html: virtual_f) *)
let f (Closure.Prog(fundefs, e)) =
  data := [];
  let fundefs = List.map h fundefs in
  let e = g M.empty e in
  Prog(!data, fundefs, e)
