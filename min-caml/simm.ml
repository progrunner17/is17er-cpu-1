open Asm

let rec g env (range, body) = match body with (* ̿�����16bit¨�ͺ�Ŭ�� (caml2html: simm13_g) *)
  | Ans(exp) -> range, Ans(g' env exp)
  | Let((x, t), (range, Li(i)), e) when -32768 <= i && i < 32768 ->
      let e' = g (M.add x i env) e in
      if List.mem x (fv e') then range, Let((x, t), (range, Li(i)), e') else
      (e')
  | Let(xt, (range, Slw(y, C(i))), e) when M.mem y env -> (* for array access *)
      g env (range, Let(xt, (range, Li((M.find y env) lsl i)), e))
  | Let(xt, exp, e) -> range, Let(xt, g' env exp, g env e)
and g' env ((range, body) as e) = match body with (* ��̿���16bit¨�ͺ�Ŭ�� (caml2html: simm13_gprime) *)
  | Add(x, V(y)) when M.mem y env -> range, Add(x, C(M.find y env))
  | Add(x, V(y)) when M.mem x env -> range, Add(y, C(M.find x env))
  | Sub(x, V(y)) when M.mem y env -> range, Sub(x, C(M.find y env))
  | Slw(x, V(y)) when M.mem y env -> range, Slw(x, C(M.find y env))
  | Lwz(x, V(y)) when M.mem y env -> range, Lwz(x, C(M.find y env))
  | Stw(x, y, V(z)) when M.mem z env -> range, Stw(x, y, C(M.find z env))
  | Lfd(x, V(y)) when M.mem y env -> range, Lfd(x, C(M.find y env))
  | Stfd(x, y, V(z)) when M.mem z env -> range, Stfd(x, y, C(M.find z env))
  | IfEq(x, V(y), e1, e2) when M.mem y env -> range, IfEq(x, C(M.find y env), g env e1, g env e2)
  | IfLE(x, V(y), e1, e2) when M.mem y env -> range, IfLE(x, C(M.find y env), g env e1, g env e2)
  | IfGE(x, V(y), e1, e2) when M.mem y env -> range, IfGE(x, C(M.find y env), g env e1, g env e2)
  | IfEq(x, V(y), e1, e2) when M.mem x env -> range, IfEq(y, C(M.find x env), g env e1, g env e2)
  | IfLE(x, V(y), e1, e2) when M.mem x env -> range, IfGE(y, C(M.find x env), g env e1, g env e2)
  | IfGE(x, V(y), e1, e2) when M.mem x env -> range, IfLE(y, C(M.find x env), g env e1, g env e2)
  | IfEq(x, y', e1, e2) -> range, IfEq(x, y', g env e1, g env e2)
  | IfLE(x, y', e1, e2) -> range, IfLE(x, y', g env e1, g env e2)
  | IfGE(x, y', e1, e2) -> range, IfGE(x, y', g env e1, g env e2)
  | IfFEq(x, y, e1, e2) -> range, IfFEq(x, y, g env e1, g env e2)
  | IfFLE(x, y, e1, e2) -> range, IfFLE(x, y, g env e1, g env e2)
  | _ -> e

let h { range = range; name = l; args = xs; fargs = ys; body = e; ret = t } = (* �ȥåץ�٥�ؿ���16bit¨�ͺ�Ŭ�� *)
  { range = range; name = l; args = xs; fargs = ys; body = g M.empty e; ret = t }

let f (Prog(data, fundefs, e)) = (* �ץ�������Τ�16bit¨�ͺ�Ŭ�� *)
  Prog(data, List.map h fundefs, g M.empty e)
