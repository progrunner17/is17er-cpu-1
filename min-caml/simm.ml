open Asm

let rec g env fenv (range, body) = match body with (* 命令列の即値最適化 (caml2html: simm13_g) *)
  | Ans(exp) -> range, Ans(g' env fenv exp)
  | Let(range', (x, t), (range'', LI(n)), e) ->
      let e' = g (M.add x n env) fenv e in
      if not (List.mem x (fv e')) then e' else
      range, Let(range', (x, t), (range'', LI(n)), e')
  | Let(range', (x, t), (range'', FLI(a)), e) ->
      let e' = g env (M.add x a fenv) e in
      if not (List.mem x (fv e')) then e' else
      range, Let(range', (x, t), (range'', FLI(a)), e')
  | Let(range', xt, (range'', AddI(y, n)), e) when M.mem y env ->
      g env fenv (range, Let(range', xt, (range'', LI(M.find y env + n)), e))
  | Let(range', xt, exp, e) -> range, Let(range', xt, g' env fenv exp, g env fenv e)
and g' env fenv ((range, body) as e) = match body with (* 各命令の即値最適化 (caml2html: simm13_gprime) *)
  | Xor(x, y) -> range, Xor(modify env x, modify env y)
  | Add(x, y) when good env (-2048) 2047 y -> range, AddI(x, M.find y env)
  | Add(x, y) when good env (-2048) 2047 x -> range, AddI(y, M.find x env)
  | Add(x, y) -> range, Add(modify env x, modify env y)
  | Sub(x, y) when good env (-2047) 2048 y -> range, AddI(modify env x, - M.find y env)
  | Sub(x, y) -> range, Sub(modify env x, modify env y)
  | LWA(x, y) when good env (-2048) 2047 y -> range, LW(modify env x, M.find y env)
  | SWA(x, y, z) when good env (-2048) 2047 z -> range, SW(modify env x, modify env y, M.find z env)
  | FAdd(x, y) -> range, FAdd(fmodify fenv x, fmodify fenv y)
  | FSub(x, y) -> range, FSub(fmodify fenv x, fmodify fenv y)
  | FMul(x, y) -> range, FMul(fmodify fenv x, fmodify fenv y)
  | FDiv(x, y) -> range, FDiv(fmodify fenv x, fmodify fenv y)
  | FEq(x, y) -> range, FEq(fmodify fenv x, fmodify fenv y)
  | FLT(x, y) -> range, FLT(fmodify fenv y, fmodify fenv y)
  | FLWA(x, y) when good env (-2048) 2047 y -> range, FLW(x, M.find y env)
  | FSWA(x, y, z) when good env (-2048) 2047 z -> range, FSW(x, y, M.find z env)
  | IfEq(range', x, y, e1, e2)
      -> range, IfEq(range', modify env x, modify env y, g env fenv e1, g env fenv e2)
  | IfLT(range', x, y, e1, e2)
      -> range, IfLT(range', modify env x, modify env y, g env fenv e1, g env fenv e2)
  | _ -> e
and good env min max x = try let n = M.find x env in min <= n && n <= max with Not_found -> false
and modify env x = try reg_const @@ M.find x env with Not_found -> x
and fmodify fenv x = try freg_const @@ M.find x fenv with Not_found -> x

let h { range = range; name = l; args = xs; fargs = ys; body = e; ret = t } = (* トップレベル関数の即値最適化 *)
  { range = range; name = l; args = xs; fargs = ys; body = g M.empty M.empty e; ret = t }

let f (Prog(fundefs, e)) = (* プログラム全体の即値最適化 *)
  Prog(List.map h fundefs, g M.empty M.empty e)
