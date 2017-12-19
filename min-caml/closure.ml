type closure = { entry : Id.l; actual_fv : Id.t list }
(* MATSUSHITA: added to t H.range *)
type t = H.range * body (* クロージャ変換後の式 (caml2html: closure_t) *)
and body =
  | Unit
  | Int of int
  | Float of float
  | Not of Id.t
  | Xor of Id.t * Id.t
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | SllI of Id.t * int
  | SraI of Id.t * int
  | AndI of Id.t * int
  | FNeg of Id.t
  | FAbs of Id.t
  | FFloor of Id.t
  | IToF of Id.t
  | FToI of Id.t
  | FSqrt of Id.t
  | FCos of Id.t
  | FSin of Id.t
  | FTan of Id.t
  | FAtan of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | FEq of Id.t * Id.t
  | FLT of Id.t * Id.t
  | IfEq of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | IfLT of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | Let of H.range * (Id.t * Type.t) * t * t (* MATSUSHITA: added H.range *)
  | Var of Id.t
  | MakeCls of H.range * (Id.t * Type.t) * closure * t (* MATSUSHITA: added H.range *)
  | AppCls of Id.t * Id.t list
  | AppDir of Id.l * Id.t list
  | Tuple of Id.t list
  | LetTuple of H.range * (Id.t * Type.t) list * Id.t * t (* MATSUSHITA: added H.range *)
  | Array of Id.t * Id.t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.l
  | Read
  | Write of Id.t
  | FRead
type fundef = { range : H.range; (* MATSUSHITA: added H.range *)
                name : Id.l * Type.t;
                args : (Id.t * Type.t) list;
                formal_fv : (Id.t * Type.t) list;
                body : t }
type prog = Prog of fundef list * t

(* MATSUSHITA: added functions show and show_prog *)

let rec show lines (range, body) = match body with
  | Unit -> "()"^H.comment_from_range lines range
  | Int n -> string_of_int n^H.comment_from_range lines range
  | Float a -> string_of_float a^H.comment_from_range lines range
  | Not x -> "not "^x^H.comment_from_range lines range
  | Xor (x, x') -> x^" xor "^x'^H.comment_from_range lines range
  | Neg x -> "- "^x^H.comment_from_range lines range
  | Add (x, x') -> x^" + "^x'^H.comment_from_range lines range
  | Sub (x, x') -> x^" - "^x'^H.comment_from_range lines range
  | SllI (x, n) -> x^" sll "^string_of_int n^H.comment_from_range lines range
  | SraI (x, n) -> x^" sra "^string_of_int n^H.comment_from_range lines range
  | AndI (x, n) -> x^" and "^string_of_int n^H.comment_from_range lines range
  | FNeg x -> "-. "^x^H.comment_from_range lines range
  | FAbs x -> "fabs "^x^H.comment_from_range lines range
  | FFloor x -> "ffloor "^x^H.comment_from_range lines range
  | IToF x -> "itof "^x^H.comment_from_range lines range
  | FToI x -> "ftoi "^x^H.comment_from_range lines range
  | FSqrt x -> "fsqrt "^x^H.comment_from_range lines range
  | FCos x -> "fcos "^x^H.comment_from_range lines range
  | FSin x -> "fsin "^x^H.comment_from_range lines range
  | FTan x -> "ftan "^x^H.comment_from_range lines range
  | FAtan x -> "fatan "^x^H.comment_from_range lines range
  | FAdd (x, x') -> x^" +. "^x'^H.comment_from_range lines range
  | FSub (x, x') -> x^" -. "^x'^H.comment_from_range lines range
  | FMul (x, x') -> x^" *. "^x'^H.comment_from_range lines range
  | FDiv (x, x') -> x^" /. "^x'^H.comment_from_range lines range
  | FEq (x, x') -> x^" =. "^x'^H.comment_from_range lines range
  | FLT (x, x') -> x^" <. "^x'^H.comment_from_range lines range
  | IfEq (range', x, x', e, e') ->
      let s1 = "if "^x^" = "^x'^H.comment_from_range lines range'
        ^" then"^H.comment_from_range lines (fst e)^H.down_right () in
      let s2 = s1^show lines e in
      let s3 = s2^H.down_left () in
      let s4 = s3^"else"^H.comment_from_range lines (fst e')^H.down_right () in
      let s5 = s4^show lines e' in
      s5^H.left ()
  | IfLT (range', x, x', e, e') ->
      let s1 = "if "^x^" < "^x'^H.comment_from_range lines range'
        ^" then"^H.comment_from_range lines (fst e)^H.down_right () in
      let s2 = s1^show lines e in
      let s3 = s2^H.down_left () in
      let s4 = s3^"else"^H.comment_from_range lines (fst e')^H.down_right () in
      let s5 = s4^show lines e' in
      s5^H.left ()
  | Let (range', (x, t), e, e') ->
      let s1 = "let "^x^":"^Type.show t^H.comment_from_range lines range'^" = "^show lines e^" in" in
      let s2 = s1^H.down () in
      s2^show lines e'
  | Var x -> x^H.comment_from_range lines range
  | MakeCls (range', (f, t), {entry = Id.L y; actual_fv = lxs}, e) ->
      let s1 = "let_cls "^f^":"^Type.show t
        ^" = *"^y^"*"^(if lxs = [] then "" else " <"^String.concat ", " lxs^">")
        ^H.comment_from_range lines range'^" in"^H.down () in
      s1^show lines e
  | AppCls (x, xs) -> x^H.sep "" (fun x -> " "^x) xs^H.comment_from_range lines range
  | AppDir (Id.L x, xs) -> "*"^x^"*"^H.sep "" (fun x -> " "^x) xs^H.comment_from_range lines range
  | Tuple xs -> "("^String.concat ", " xs^")"^H.comment_from_range lines range
  | LetTuple (range', xts, x, e) ->
      let s1 = "let ("^H.sep ", " (fun (x, t) -> x^":"^Type.show t) xts^") = "
        ^x^H.comment_from_range lines range'^" in"^H.down () in
      s1^show lines e
  | Array (x, x') -> "array "^x^" "^x'^H.comment_from_range lines range
  | Get (x, x') -> x^".("^x'^")"^H.comment_from_range lines range
  | Put (x, x', x'') -> x^".("^x'^") <- "^x''^H.comment_from_range lines range
  | ExtArray (Id.L x) -> "*"^x^"*"^H.comment_from_range lines range
  | Read -> "read"^H.comment_from_range lines range
  | FRead -> "fread"^H.comment_from_range lines range
  | Write x -> "write "^x^H.comment_from_range lines range

let show_prog lines (Prog (fs, e)) =
  let s1 = H.sep "" (fun {range = range; name = Id.L f, t; args = xts; formal_fv = yts; body = e} ->
    let s1 = "let_fun (*"^f^"*:"^Type.show t^") "
      ^(if yts = [] then "" else "<"^H.sep ", " (fun (x, t) -> x^":"^Type.show t) yts^"> ")
      ^H.sep " " (fun (x, t) -> "("^x^":"^Type.show t^")") xts^" ="
      ^H.comment_from_range lines range^H.down_right () in
    let s2 = s1^show lines e in
    s2^" in"^H.down_left ()) fs in
  s1^show lines e

let rec fv (_, body) = match body with
  | Unit | Int(_) | Float(_) | ExtArray(_)| Read | FRead -> S.empty
  | Not(x) | Neg(x) | SllI(x, _) | SraI(x, _) | AndI(x, _)
  | FNeg(x) | FAbs(x) | FFloor(x) | IToF(x) | FToI(x) | FSqrt(x) | FCos(x) | FSin(x) | FTan(x) | FAtan(x)
  | Write(x) -> S.singleton x
  | Xor(x, y) | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | FEq(x, y) | FLT(x, y) | Array(x, y) | Get(x, y) -> S.of_list [x; y]
  | IfEq(_, x, y, e1, e2)| IfLT(_, x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
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
  | KNormal.Not(x) -> range, Not(x)
  | KNormal.Xor(x, y) -> range, Xor(x, y)
  | KNormal.Neg(x) -> range, Neg(x)
  | KNormal.Add(x, y) -> range, Add(x, y)
  | KNormal.Sub(x, y) -> range, Sub(x, y)
  | KNormal.SllI(x, n) -> range, SllI(x, n)
  | KNormal.SraI(x, n) -> range, SraI(x, n)
  | KNormal.AndI(x, n) -> range, AndI(x, n)
  | KNormal.FNeg(x) -> range, FNeg(x)
  | KNormal.FAbs(x) -> range, FAbs(x)
  | KNormal.FFloor(x) -> range, FFloor(x)
  | KNormal.IToF(x) -> range, IToF(x)
  | KNormal.FToI(x) -> range, FToI(x)
  | KNormal.FSqrt(x) -> range, FSqrt(x)
  | KNormal.FCos(x) -> range, FCos(x)
  | KNormal.FSin(x) -> range, FSin(x)
  | KNormal.FTan(x) -> range, FTan(x)
  | KNormal.FAtan(x) -> range, FAtan(x)
  | KNormal.FAdd(x, y) -> range, FAdd(x, y)
  | KNormal.FSub(x, y) -> range, FSub(x, y)
  | KNormal.FMul(x, y) -> range, FMul(x, y)
  | KNormal.FDiv(x, y) -> range, FDiv(x, y)
  | KNormal.FEq(x, y) -> range, FEq(x, y)
  | KNormal.FLT(x, y) -> range, FLT(x, y)
  | KNormal.IfEq(range', x, y, e1, e2) -> range, IfEq(range', x, y, g env known e1, g env known e2)
  | KNormal.IfLT(range', x, y, e1, e2) -> range, IfLT(range', x, y, g env known e1, g env known e2)
  | KNormal.Let(range', (x, t), e1, e2) -> range, Let(range', (x, t), g env known e1, g (M.add x t env) known e2)
  | KNormal.Var(x) -> range, Var(x)
  | KNormal.LetRec(range', { KNormal.name = (x, t); KNormal.args = yts; KNormal.body = e1 }, ((range'', _) as e2)) -> (* ´Ø¿ôÄêµÁ¤Î¾ì¹ç (caml2html: closure_letrec) *)
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
        let fvs = S.elements zs in
        let _ = Printf.printf "Free variable%s %s found in function %s\n"
          (if List.length fvs = 1 then "" else "s") (String.concat " " fvs) x in
        let _ = Printf.printf "Function %s cannot be directly applied\n" x in
        let _ = toplevel := toplevel_backup in
        let e1' = g (M.add_list yts env') known e1 in
        known, e1' in
      let zs = S.elements (S.diff (fv e1') (S.add x (S.of_list (List.map fst yts)))) in (* 自由変数のリスト *)
      let zts = List.map (fun z -> (z, M.find z env')) zs in (* ここで自由変数zの型を引くために引数envが必要 *)
      toplevel := { range = range'; name = (Id.L(x), t); args = yts; formal_fv = zts; body = e1' } :: !toplevel; (* トップレベル関数を追加 *)
      let e2' = g env' known' e2 in
      if S.mem x (fv e2') then (* xが変数としてe2'に出現するか *)
        range, MakeCls(range', (x, t), { entry = Id.L(x); actual_fv = zs }, e2') (* 出現していたら削除しない *)
      else
        e2' (* 出現しなければMakeClsを削除 *)
  | KNormal.App(x, ys) when S.mem x known -> (* 関数適用の場合 (caml2html: closure_app) *)
      range, AppDir(Id.L(x), ys)
  | KNormal.App(f, xs) -> range, AppCls(f, xs)
  | KNormal.Tuple(xs) -> range, Tuple(xs)
  | KNormal.LetTuple(range', xts, y, e) -> range, LetTuple(range', xts, y, g (M.add_list xts env) known e)
  | KNormal.Array(x, y) -> range, Array(x, y)
  | KNormal.Get(x, y) -> range, Get(x, y)
  | KNormal.Put(x, y, z) -> range, Put(x, y, z)
  | KNormal.ExtArray(x) -> range, ExtArray(Id.L(x))
  | KNormal.ExtFunApp(x, ys) -> range, AppDir(Id.L("min_caml_" ^ x), ys)
  | KNormal.Read -> range, Read
  | KNormal.FRead -> range, FRead
  | KNormal.Write x -> range, Write x

let f e =
  toplevel := [];
  let e' = g M.empty S.empty e in
  Prog(List.rev !toplevel, e')
