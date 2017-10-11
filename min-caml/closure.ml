type closure = { entry : Id.l; actual_fv : Id.t list }
type t = H.range * body (* ���������Ѵ���μ� (caml2html: closure_t) *)
and body =
  | Unit
  | Int of int
  | Float of float
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | IfEq of Id.t * Id.t * t * t
  | IfLE of Id.t * Id.t * t * t
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | MakeCls of (Id.t * Type.t) * closure * t
  | AppCls of Id.t * Id.t list
  | AppDir of Id.l * Id.t list
  | Tuple of Id.t list
  | LetTuple of (Id.t * Type.t) list * Id.t * t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.l
type fundef = { range : H.range;
                name : Id.l * Type.t;
                args : (Id.t * Type.t) list;
                formal_fv : (Id.t * Type.t) list;
                body : t }
type prog = Prog of fundef list * t

let complex (range, body) = match body with
  | Let (_, _, _) | LetTuple (_, _, _) -> true
  | _ -> false

let rec show (range, body) = "["^H.show_range range^"] "^match body with
  | Unit -> "()"
  | Int n -> string_of_int n
  | Float a -> string_of_float a
  | Neg x -> "- "^x
  | Add (x, x') -> x^" + "^x'
  | Sub (x, x') -> x^" - "^x'
  | FNeg x -> "-. "^x
  | FAdd (x, x') -> x^" +. "^x'
  | FSub (x, x') -> x^" -. "^x'
  | FMul (x, x') -> x^" *. "^x'
  | FDiv (x, x') -> x^" /. "^x'
  | IfEq (x, x', e, e') ->
    let s1 = "if "^x^" = "^x'^" then"^H.down_right () in
    let s2 = s1^show e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else "^H.down_right () in
    let s5 = s4^show e' in
    s5^H.left ()
  | IfLE (x, x', e, e') ->
    let s1 = "if "^x^" <= "^x'^" then"^H.down_right () in
    let s2 = s1^show e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else "^H.down_right () in
    let s5 = s4^show e' in
    s5^H.left ()
  | Let ((x, t), e, e') -> if complex e then
      let s1 = "let "^x^":"^Type.show t^" ="^H.down_right () in
      let s2 = s1^show e^" in" in
      let s3 = s2^H.down_left () in
      s3^show e'
    else
      let s1 = "let "^x^":"^Type.show t^" = "^show e^" in" in
      let s2 = s1^H.down () in
      s2^show e'
  | Var x -> x
  | MakeCls ((x, t), {entry = Id.L y; actual_fv = lxs}, e) -> show e
  | AppCls (x, xs) -> x^H.sep "" (fun x -> " "^x) xs
  | AppDir (Id.L x, xs) -> "*"^x^"*"^H.sep "" (fun x -> " "^x) xs
  | Tuple xs -> "("^String.concat ", " xs^")"
  | LetTuple (xts, x, e) ->
    let s1 = "let ("^H.sep ", " (fun (x, t) -> x^":"^Type.show t) xts^") = "^x^" in"^H.down () in
    s1^show e
  | Get (x, x') -> x^".("^x'^")"
  | Put (x, x', x'') -> x^".("^x'^") <- "^x''
  | ExtArray (Id.L x) -> "*"^x^"*"

let show_prog (Prog (fs, e)) =
  let s1 = H.sep "" (fun {name = Id.L f, t; args = xts; formal_fv = yts; body = e} ->
    let s1 = "let_fun (*"^f^"*:"^Type.show t^") "^H.sep " " (fun (x, t) -> "("^x^":"^Type.show t^")") xts in
    let s2 = s1^(if yts = [] then " =" else " <"^H.sep ", " (fun (x, t) -> x^":"^Type.show t) yts^"> =")^H.down_right () in
    let s3 = s2^show e in
    s3^" in"^H.down_left ()) fs in
  s1^show e

let rec fv (_, body) = match body with
  | Unit | Int(_) | Float(_) | ExtArray(_) -> S.empty
  | Neg(x) | FNeg(x) -> S.singleton x
  | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | Get(x, y) -> S.of_list [x; y]
  | IfEq(x, y, e1, e2)| IfLE(x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let((x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | MakeCls((x, t), { entry = l; actual_fv = ys }, e) -> S.remove x (S.union (S.of_list ys) (fv e))
  | AppCls(x, ys) -> S.of_list (x :: ys)
  | AppDir(_, xs) | Tuple(xs) -> S.of_list xs
  | LetTuple(xts, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xts)))
  | Put(x, y, z) -> S.of_list [x; y; z]

let toplevel : fundef list ref = ref []

let rec g env known (range, body) = match body with (* ���������Ѵ��롼�������� (caml2html: closure_g) *)
  | KNormal.Unit -> range, Unit
  | KNormal.Int(i) -> range, Int(i)
  | KNormal.Float(d) -> range, Float(d)
  | KNormal.Neg(x) -> range, Neg(x)
  | KNormal.Add(x, y) -> range, Add(x, y)
  | KNormal.Sub(x, y) -> range, Sub(x, y)
  | KNormal.FNeg(x) -> range, FNeg(x)
  | KNormal.FAdd(x, y) -> range, FAdd(x, y)
  | KNormal.FSub(x, y) -> range, FSub(x, y)
  | KNormal.FMul(x, y) -> range, FMul(x, y)
  | KNormal.FDiv(x, y) -> range, FDiv(x, y)
  | KNormal.IfEq(x, y, e1, e2) -> range, IfEq(x, y, g env known e1, g env known e2)
  | KNormal.IfLE(x, y, e1, e2) -> range, IfLE(x, y, g env known e1, g env known e2)
  | KNormal.Let((x, t), e1, e2) -> range, Let((x, t), g env known e1, g (M.add x t env) known e2)
  | KNormal.Var(x) -> range, Var(x)
  | KNormal.LetRec({ KNormal.name = (x, t); KNormal.args = yts; KNormal.body = e1 }, e2) -> (* �ؿ�����ξ�� (caml2html: closure_letrec) *)
      (* �ؿ����let rec x y1 ... yn = e1 in e2�ξ��ϡ�
         x�˼�ͳ�ѿ����ʤ�(closure��𤵤�direct�˸ƤӽФ���)
         �Ȳ��ꤷ��known���ɲä���e1�򥯥������Ѵ����Ƥߤ� *)
      let toplevel_backup = !toplevel in
      let env' = M.add x t env in
      let known' = S.add x known in
      let e1' = g (M.add_list yts env') known' e1 in
      (* �����˼�ͳ�ѿ����ʤ��ä������Ѵ����e1'���ǧ���� *)
      (* ���: e1'��x���Ȥ��ѿ��Ȥ��ƽи��������closure��ɬ��!
         (thanks to nuevo-namasute and azounoman; test/cls-bug2.ml����) *)
      let zs = S.diff (fv e1') (S.of_list (List.map fst yts)) in
      let known', e1' =
        if S.is_empty zs then known', e1' else
        (* ���ܤ��ä������(toplevel����)���ᤷ�ơ����������Ѵ�����ľ�� *)
        (Printf.printf "Free variable(s) %s found in function %s\n" (Id.pp_list (S.elements zs)) x;
         Printf.printf "Function %s cannot be directly applied in fact\n" x;
         toplevel := toplevel_backup;
         let e1' = g (M.add_list yts env') known e1 in
         known, e1') in
      let zs = S.elements (S.diff (fv e1') (S.add x (S.of_list (List.map fst yts)))) in (* ��ͳ�ѿ��Υꥹ�� *)
      let zts = List.map (fun z -> (z, M.find z env')) zs in (* �����Ǽ�ͳ�ѿ�z�η����������˰���env��ɬ�� *)
      toplevel := { range = range; name = (Id.L(x), t); args = yts; formal_fv = zts; body = e1' } :: !toplevel; (* �ȥåץ�٥�ؿ����ɲ� *)
      let e2' = g env' known' e2 in
      if S.mem x (fv e2') then (* x���ѿ��Ȥ���e2'�˽и����뤫 *)
        range, MakeCls((x, t), { entry = Id.L(x); actual_fv = zs }, e2') (* �и����Ƥ����������ʤ� *)
      else
        (Printf.printf "Eliminating closure(s) %s\n" x;
         e2') (* �и����ʤ����MakeCls���� *)
  | KNormal.App(x, ys) when S.mem x known -> (* �ؿ�Ŭ�Ѥξ�� (caml2html: closure_app) *)
      Printf.printf "Directly applying %s\n" x;
      range, AppDir(Id.L(x), ys)
  | KNormal.App(f, xs) -> range, AppCls(f, xs)
  | KNormal.Tuple(xs) -> range, Tuple(xs)
  | KNormal.LetTuple(xts, y, e) -> range, LetTuple(xts, y, g (M.add_list xts env) known e)
  | KNormal.Get(x, y) -> range, Get(x, y)
  | KNormal.Put(x, y, z) -> range, Put(x, y, z)
  | KNormal.ExtArray(x) -> range, ExtArray(Id.L(x))
  | KNormal.ExtFunApp(x, ys) -> range, AppDir(Id.L("min_caml_" ^ x), ys)

let f e =
  toplevel := [];
  let e' = g M.empty S.empty e in
  Prog(List.rev !toplevel, e')
