type closure = { entry : Id.l; actual_fv : Id.t list }
(* MATSUSHITA: added to t H.range *)
type t = H.range * body (* クロージャ変換後の式 (caml2html: closure_t) *)
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
  | IfEq of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | IfLE of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | Let of H.range * (Id.t * Type.t) * t * t (* MATSUSHITA: added H.range *)
  | Var of Id.t
  | MakeCls of H.range * (Id.t * Type.t) * closure * t (* MATSUSHITA: added H.range *)
  | AppCls of Id.t * Id.t list
  | AppDir of Id.l * Id.t list
  | Tuple of Id.t list
  | LetTuple of H.range * (Id.t * Type.t) list * Id.t * t (* MATSUSHITA: added H.range *)
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.l
type fundef = { range : H.range; (* MATSUSHITA: added H.range *)
                name : Id.l * Type.t;
                args : (Id.t * Type.t) list;
                formal_fv : (Id.t * Type.t) list;
                body : t }
type prog = Prog of fundef list * t

(* MATSUSHITA: added show function *)
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
  | IfEq (range', x, x', e, e') ->
      let s1 = "if ["^H.show_range range'^"] "^x^" = "^x'^" then"^H.down_right () in
      let s2 = s1^show e in
      let s3 = s2^H.down_left () in
      let s4 = s3^"else "^H.down_right () in
      let s5 = s4^show e' in
      s5^H.left ()
  | IfLE (range', x, x', e, e') ->
      let s1 = "if ["^H.show_range range'^"] "^x^" <= "^x'^" then"^H.down_right () in
      let s2 = s1^show e in
      let s3 = s2^H.down_left () in
      let s4 = s3^"else "^H.down_right () in
      let s5 = s4^show e' in
      s5^H.left ()
  | Let (range', (x, t), e, e') ->
      let s1 = "let ["^H.show_range range'^"] "^x^":"^Type.show t^" = "^show e^" in" in
      let s2 = s1^H.down () in
      s2^show e'
  | Var x -> x
  | MakeCls (range', (f, t), {entry = Id.L y; actual_fv = lxs}, e) ->
      let s1 = "let_fun ["^H.show_range range'^"] (*"^f^"*:"^Type.show t^") "^y^(if lxs = [] then " = " else " <"^String.concat ", " lxs^"> = ") in
      s1^show e
  | AppCls (x, xs) -> x^H.sep "" (fun x -> " "^x) xs
  | AppDir (Id.L x, xs) -> "*"^x^"*"^H.sep "" (fun x -> " "^x) xs
  | Tuple xs -> "("^String.concat ", " xs^")"
  | LetTuple (range', xts, x, e) ->
      let s1 = "let ["^H.show_range range'^"] ("^H.sep ", " (fun (x, t) -> x^":"^Type.show t) xts^") = "^x^" in"^H.down () in
      s1^show e
  | Get (x, x') -> x^".("^x'^")"
  | Put (x, x', x'') -> x^".("^x'^") <- "^x''
  | ExtArray (Id.L x) -> "*"^x^"*"

(* MATSUSHITA: added show_prog function *)
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
  | IfEq(_, x, y, e1, e2)| IfLE(_, x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let(_, (x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | MakeCls(_, (x, t), { entry = l; actual_fv = ys }, e) -> S.remove x (S.union (S.of_list ys) (fv e))
  | AppCls(x, ys) -> S.of_list (x :: ys)
  | AppDir(_, xs) | Tuple(xs) -> S.of_list xs
  | LetTuple(_, xts, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xts)))
  | Put(x, y, z) -> S.of_list [x; y; z]

let toplevel : fundef list ref = ref []

let rec g env known (range, body) = match body with (* クロージャ変換ルーチン本体 (caml2html: closure_g) *)
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
  | KNormal.IfEq(range', x, y, e1, e2) -> range, IfEq(range', x, y, g env known e1, g env known e2)
  | KNormal.IfLE(range', x, y, e1, e2) -> range, IfLE(range', x, y, g env known e1, g env known e2)
  | KNormal.Let(range', (x, t), e1, e2) -> range, Let(range', (x, t), g env known e1, g (M.add x t env) known e2)
  | KNormal.Var(x) -> range, Var(x)
  | KNormal.LetRec(range', { KNormal.name = (x, t); KNormal.args = yts; KNormal.body = e1 }, e2) -> (* 関数定義の場合 (caml2html: closure_letrec) *)
      (* 関数定義let rec x y1 ... yn = e1 in e2の場合は、
         xに自由変数がない(closureを介さずdirectに呼び出せる)
         と仮定し、knownに追加してe1をクロージャ変換してみる *)
      let toplevel_backup = !toplevel in
      let env' = M.add x t env in
      let known' = S.add x known in
      let e1' = g (M.add_list yts env') known' e1 in
      (* 本当に自由変数がなかったか、変換結果e1'を確認する *)
      (* 注意: e1'にx自身が変数として出現する場合はclosureが必要!
         (thanks to nuevo-namasute and azounoman; test/cls-bug2.ml参照) *)
      let zs = S.diff (fv e1') (S.of_list (List.map fst yts)) in
      let known', e1' =
        if S.is_empty zs then known', e1' else
        (* 駄目だったら状態(toplevelの値)を戻して、クロージャ変換をやり直す *)
        (Printf.printf "Free variable(s) %s found in function %s\n" (Id.pp_list (S.elements zs)) x;
         Printf.printf "Function %s cannot be directly applied in fact\n" x;
         toplevel := toplevel_backup;
         let e1' = g (M.add_list yts env') known e1 in
         known, e1') in
      let zs = S.elements (S.diff (fv e1') (S.add x (S.of_list (List.map fst yts)))) in (* 自由変数のリスト *)
      let zts = List.map (fun z -> (z, M.find z env')) zs in (* ここで自由変数zの型を引くために引数envが必要 *)
      toplevel := { range = range'; name = (Id.L(x), t); args = yts; formal_fv = zts; body = e1' } :: !toplevel; (* トップレベル関数を追加 *)
      let e2' = g env' known' e2 in
      if S.mem x (fv e2') then (* xが変数としてe2'に出現するか *)
        range, MakeCls(range', (x, t), { entry = Id.L(x); actual_fv = zs }, e2') (* 出現していたら削除しない *)
      else
        (Printf.printf "Eliminating closure(s) %s\n" x;
         e2') (* 出現しなければMakeClsを削除 *)
  | KNormal.App(x, ys) when S.mem x known -> (* 関数適用の場合 (caml2html: closure_app) *)
      Printf.printf "Directly applying %s\n" x;
      range, AppDir(Id.L(x), ys)
  | KNormal.App(f, xs) -> range, AppCls(f, xs)
  | KNormal.Tuple(xs) -> range, Tuple(xs)
  | KNormal.LetTuple(range', xts, y, e) -> range, LetTuple(range', xts, y, g (M.add_list xts env) known e)
  | KNormal.Get(x, y) -> range, Get(x, y)
  | KNormal.Put(x, y, z) -> range, Put(x, y, z)
  | KNormal.ExtArray(x) -> range, ExtArray(Id.L(x))
  | KNormal.ExtFunApp(x, ys) -> range, AppDir(Id.L("min_caml_" ^ x), ys)

let f e =
  toplevel := [];
  let e' = g M.empty S.empty e in
  Prog(List.rev !toplevel, e')
