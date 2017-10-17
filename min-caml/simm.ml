open Asm

let rec g env (range, body) = match body with (* 命令列の16bit即値最適化 (caml2html: simm13_g) *)
  | Ans(exp) -> range, Ans(g' env exp)
  | Let(range', (x, t), (range, Li(i)), e) when -32768 <= i && i < 32768 ->
      let e' = g (M.add x i env) e in
      if List.mem x (fv e') then range, Let(range', (x, t), (range, Li(i)), e') else
      (e')
  | Let(range', xt, (range, Slw(y, C(i))), e) when M.mem y env -> (* for array access *)
      g env (range, Let(range', xt, (range, Li((M.find y env) lsl i)), e))
  | Let(range', xt, exp, e) -> range, Let(range', xt, g' env exp, g env e)
and g' env ((range, body) as e) = match body with (* 各命令の16bit即値最適化 (caml2html: simm13_gprime) *)
  | Add(x, V(y)) when M.mem y env -> range, Add(x, C(M.find y env))
  | Add(x, V(y)) when M.mem x env -> range, Add(y, C(M.find x env))
  | Sub(x, V(y)) when M.mem y env -> range, Sub(x, C(M.find y env))
  | Slw(x, V(y)) when M.mem y env -> range, Slw(x, C(M.find y env))
  | Lwz(x, V(y)) when M.mem y env -> range, Lwz(x, C(M.find y env))
  | Stw(x, y, V(z)) when M.mem z env -> range, Stw(x, y, C(M.find z env))
  | Lfd(x, V(y)) when M.mem y env -> range, Lfd(x, C(M.find y env))
  | Stfd(x, y, V(z)) when M.mem z env -> range, Stfd(x, y, C(M.find z env))
  | IfEq(range', x, V(y), e1, e2) when M.mem y env -> range, IfEq(range', x, C(M.find y env), g env e1, g env e2)
  | IfLE(range', x, V(y), e1, e2) when M.mem y env -> range, IfLE(range', x, C(M.find y env), g env e1, g env e2)
  | IfGE(range', x, V(y), e1, e2) when M.mem y env -> range, IfGE(range', x, C(M.find y env), g env e1, g env e2)
  | IfEq(range', x, V(y), e1, e2) when M.mem x env -> range, IfEq(range', y, C(M.find x env), g env e1, g env e2)
  | IfLE(range', x, V(y), e1, e2) when M.mem x env -> range, IfGE(range', y, C(M.find x env), g env e1, g env e2)
  | IfGE(range', x, V(y), e1, e2) when M.mem x env -> range, IfLE(range', y, C(M.find x env), g env e1, g env e2)
  | IfEq(range', x, y', e1, e2) -> range, IfEq(range', x, y', g env e1, g env e2)
  | IfLE(range', x, y', e1, e2) -> range, IfLE(range', x, y', g env e1, g env e2)
  | IfGE(range', x, y', e1, e2) -> range, IfGE(range', x, y', g env e1, g env e2)
  | IfFEq(range', x, y, e1, e2) -> range, IfFEq(range', x, y, g env e1, g env e2)
  | IfFLE(range', x, y, e1, e2) -> range, IfFLE(range', x, y, g env e1, g env e2)
  | _ -> e

let h { range = range; name = l; args = xs; fargs = ys; body = e; ret = t } = (* トップレベル関数の16bit即値最適化 *)
  { range = range; name = l; args = xs; fargs = ys; body = g M.empty e; ret = t }

let f (Prog(data, fundefs, e)) = (* プログラム全体の16bit即値最適化 *)
  Prog(data, List.map h fundefs, g M.empty e)
