(* give names to intermediate values (K-normalization) *)

(* MATSUSHITA: added to t H.range *)
type t = H.range * body (* K正規化後の式 (caml2html: knormal_t) *)
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
  | IfEq of H.range * Id.t * Id.t * t * t (* 比較 + 分岐 (caml2html: knormal_branch) *) (* MATSUSHITA: added H.range *)
  | IfLT of H.range * Id.t * Id.t * t * t (* 比較 + 分岐 *) (* MATSUSHITA: added H.range *)
  | Let of H.range * (Id.t * Type.t) * t * t (* MATSUSHITA: added H.range *)
  | Var of Id.t
  | LetRec of H.range * fundef * t (* MATSUSHITA: added H.range *)
  | App of Id.t * Id.t list
  | Tuple of Id.t list
  | LetTuple of H.range * (Id.t * Type.t) list * Id.t * t (* MATSUSHITA: added H.range *)
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.t
  | ExtFunApp of Id.t * Id.t list
  | Read
  | Write of Id.t
  | FRead
  | FWrite of Id.t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

(* MATSUSHITA: added functions show and subst *)

let rec show lines (range, body) = match body with
  | Unit -> "()"^H.comment_from_range lines range
  | Int n -> string_of_int n^H.comment_from_range lines range
  | Float a -> string_of_float a^H.comment_from_range lines range
  | Not x -> "not "^x^H.comment_from_range lines range
  | Xor (x, x') -> x^" xor "^x'^H.comment_from_range lines range
  | Neg x -> "-"^x^H.comment_from_range lines range
  | Add (x, x') -> x^" + "^x'^H.comment_from_range lines range
  | Sub (x, x') -> x^" - "^x'^H.comment_from_range lines range
  | SllI (x, n) -> x^" sll "^string_of_int n^H.comment_from_range lines range
  | SraI (x, n) -> x^" sra "^string_of_int n^H.comment_from_range lines range
  | AndI (x, n) -> x^" and "^string_of_int n^H.comment_from_range lines range
  | FNeg x -> "-."^x^H.comment_from_range lines range
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
  | Let (range', (x, t), e, e') -> (
      match snd e with Let _ | LetRec _ | LetTuple _ ->
        let s1 = "let "^x^":"^Type.show t
          ^" ="^H.comment_from_range lines range'^H.down_right () in
        let s2 = s1^show lines e^" in" in
        let s3 = s2^H.down_left () in
        s3^show lines e'
      | _ ->
        let s1 = "let "^x^":"^Type.show t
          ^H.comment_from_range lines range'^" = "^show lines e^" in" in
        let s2 = s1^H.down () in
        s2^show lines e')
  | Var x -> x^H.comment_from_range lines range
  | LetRec (range', f, e) ->
      let s1 = "let rec"^H.sep "" (fun (x, t) -> " ("^x^":"^Type.show t^")") (f.name :: f.args)
        ^" ="^H.comment_from_range lines range'^H.down_right () in
      let s2 = s1^show lines f.body^" in" in
      let s3 = s2^H.down_left () in
      s3^show lines e
  | App (x, xs) -> x^H.sep "" (fun x -> " "^x) xs^H.comment_from_range lines range
  | Tuple xs -> "("^String.concat ", " xs^")"^H.comment_from_range lines range
  | LetTuple (range', xts, x, e) ->
      let s1 = "let ("^H.sep ", " (fun (x, t) -> x^":"^Type.show t) xts^") = "
        ^x^H.comment_from_range lines range'^" in"^H.down () in
      s1^show lines e
  | Get (x, x') -> x^".("^x'^")"^H.comment_from_range lines range
  | Put (x, x', x'') -> x^".("^x'^") <- "^x''^H.comment_from_range lines range
  | ExtArray x -> "*"^x^"*"^H.comment_from_range lines range
  | ExtFunApp (x, xs) -> "*"^x^"*"^H.sep "" (fun x -> " "^x) xs^H.comment_from_range lines range
  | Read -> "read"^H.comment_from_range lines range
  | FRead -> "fread"^H.comment_from_range lines range
  | Write x -> "write "^x^H.comment_from_range lines range
  | FWrite x -> "fwrite "^x^H.comment_from_range lines range

(* env により変数を置換する *)
let rec subst env (range, body) =
  let q x = try M.find x env with Not_found -> x in
  match body with
  | Unit | Int _ | Float _ -> range, body
  | Not x -> range, Not (q x)
  | Xor (x, x') -> range, Xor (q x, q x')
  | Neg x -> range, Neg (q x)
  | Add (x, x') -> range, Add (q x, q x')
  | Sub (x, x') -> range, Sub (q x, q x')
  | SllI (x, n) -> range, SllI (q x, n)
  | SraI (x, n) -> range, SraI (q x, n)
  | AndI (x, n) -> range, AndI (q x, n)
  | FNeg x -> range, FNeg (q x)
  | FAbs x -> range, FAbs (q x)
  | FFloor x -> range, FFloor (q x)
  | IToF x -> range, IToF (q x)
  | FToI x -> range, FToI (q x)
  | FSqrt x -> range, FSqrt (q x)
  | FCos x -> range, FCos (q x)
  | FSin x -> range, FSin (q x)
  | FTan x -> range, FTan (q x)
  | FAtan x -> range, FAtan (q x)
  | FAdd (x, x') -> range, FAdd (q x, q x')
  | FSub (x, x') -> range, FSub (q x, q x')
  | FMul (x, x') -> range, FMul (q x, q x')
  | FDiv (x, x') -> range, FDiv (q x, q x')
  | FEq (x, x') -> range, FEq (q x, q x')
  | FLT (x, x') -> range, FLT (q x, q x')
  | IfEq (range', x, x', e, e') -> range, IfEq (range', q x, q x', subst env e, subst env e')
  | IfLT (range', x, x', e, e') -> range, IfLT (range', q x, q x', subst env e, subst env e')
  | Let (range', (x, t), e, e') -> range, Let (range', (x, t), subst env e, subst env e')
  | Var x -> range, Var (q x)
  | LetRec (range', f, e) -> range, LetRec(range', { f with body = subst env f.body }, subst env e)
  | App (x, xs) -> range, App (q x, List.map (fun x -> q x) xs)
  | Tuple xs -> range, Tuple (List.map (fun x -> q x) xs)
  | LetTuple (range', xts, x, e) -> range, LetTuple(range', xts, q x, subst env e)
  | Get (x, x') -> range, Get (q x, q x')
  | Put (x, x', x'') -> range, Put (q x, q x', q x'')
  | ExtArray x -> range, ExtArray (q x)
  | ExtFunApp (x, xs) -> range, ExtFunApp (q x, List.map (fun x -> q x) xs)
  | Read -> range, Read
  | FRead -> range, FRead
  | Write x -> range, Write (q x)
  | FWrite x -> range, FWrite (q x)

let rec fv (_, body) = match body with (* 式に出現する（自由な）変数 (caml2html: knormal_fv) *)
  | Unit | Int(_) | Float(_) | ExtArray(_) | Read | FRead -> S.empty
  | Not(x) | Neg(x) | SllI(x, _) | SraI(x, _) | AndI(x, _)
  | FNeg(x) | FAbs(x) | FFloor(x) | IToF(x) | FToI(x) | FSqrt(x) | FCos(x) | FSin(x) | FTan(x) | FAtan(x)
  | Write(x) | FWrite(x) -> S.singleton x
  | Xor(x, y) | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | FEq(x, y) | FLT(x, y) | Get(x, y) -> S.of_list [x; y]
  | IfEq(_, x, y, e1, e2) | IfLT(_, x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let(_, (x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | LetRec(_, { name = (x, t); args = yts; body = e1 }, e2) ->
      let zs = S.diff (fv e1) (S.of_list (List.map fst yts)) in
      S.diff (S.union zs (fv e2)) (S.singleton x)
  | App(x, ys) -> S.of_list (x :: ys)
  | Tuple(xs) | ExtFunApp(_, xs) -> S.of_list xs
  | Put(x, y, z) -> S.of_list [x; y; z]
  | LetTuple(_, xs, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xs)))

let insert_let range ((_, body) as e, t) k = (* letを挿入する補助関数 (caml2html: knormal_insert) *)
  match body with
  | Var(x) -> k x
  | _ ->
      let x = Id.gentmp () in
      let e', t' = k x in
      (range, Let(None, (x, t), e, e')), t'

let rec g lines env (range, body) = match body with (* K正規化ルーチン本体 (caml2html: knormal_g) *)
  | Syntax.Unit -> (range, Unit), Type.Unit
  | Syntax.Bool(b) -> (range, Int(if b then 1 else 0)), Type.Int (* 論理値true, falseを整数1, 0に変換 (caml2html: knormal_bool) *)
  | Syntax.Int(i) -> (range, Int(i)), Type.Int
  | Syntax.Float(d) -> (range, Float(d)), Type.Float
  | Syntax.Not(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, Not(x)), Type.Int)
  | Syntax.Xor(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, Xor(x, y)), Type.Int))
  | Syntax.Neg(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, Neg(x)), Type.Int)
  | Syntax.Add(e1, e2) -> (* 足し算のK正規化 (caml2html: knormal_add) *)
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, Add(x, y)), Type.Int))
  | Syntax.Sub(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, Sub(x, y)), Type.Int))
  | Syntax.SllI(e, n) ->
      insert_let range (g lines env e)
        (fun x -> (range, SllI(x, n)), Type.Int)
  | Syntax.SraI(e, n) ->
      insert_let range (g lines env e)
        (fun x -> (range, SraI(x, n)), Type.Int)
  | Syntax.AndI(e, n) ->
      insert_let range (g lines env e)
        (fun x -> (range, AndI(x, n)), Type.Int)
  | Syntax.Eq _ | Syntax.LT _ as cmp ->
      g lines env (range, Syntax.If((range, cmp), (range, Syntax.Bool(true)), (range, Syntax.Bool(false))))
  | Syntax.FNeg(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FNeg(x)), Type.Float)
  | Syntax.FAbs(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FAbs(x)), Type.Float)
  | Syntax.FFloor(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FFloor(x)), Type.Float)
  | Syntax.IToF(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, IToF(x)), Type.Float)
  | Syntax.FToI(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FToI(x)), Type.Int)
  | Syntax.FSqrt(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FSqrt(x)), Type.Float)
  | Syntax.FCos(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FCos(x)), Type.Float)
  | Syntax.FSin(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FSin(x)), Type.Float)
  | Syntax.FTan(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FTan(x)), Type.Float)
  | Syntax.FAtan(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FAtan(x)), Type.Float)
  | Syntax.FAdd(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, FAdd(x, y)), Type.Float))
  | Syntax.FSub(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, FSub(x, y)), Type.Float))
  | Syntax.FMul(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, FMul(x, y)), Type.Float))
  | Syntax.FDiv(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, FDiv(x, y)), Type.Float))
  | Syntax.FEq(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, FEq(x, y)), Type.Bool))
  | Syntax.FLT(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> (range, FLT(x, y)), Type.Bool))
  | Syntax.If((_, (Syntax.Not(e1) | Syntax.NotNeg(e1))), e2, e3) -> g lines env (range, Syntax.If(e1, e3, e2))
  | Syntax.If((range', Syntax.Eq(e1, e2)), e3, e4) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y ->
              let e3', t3 = g lines env e3 in
              let e4', t4 = g lines env e4 in
              (range, IfEq(range', x, y, e3', e4')), t3))
  | Syntax.If((range', Syntax.LT(e1, e2)), e3, e4) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y ->
              let e3', t3 = g lines env e3 in
              let e4', t4 = g lines env e4 in
              (range, IfLT(range', x, y, e3', e4')), t3))
  | Syntax.If(e1, e2, e3) -> g lines env (range, Syntax.If((range, Syntax.Eq(e1, (range, Syntax.Bool(false)))), e3, e2)) (* 比較のない分岐を変換 (caml2html: knormal_if) *)
  | Syntax.Let(range', (x, t), e1, e2) ->
      let e1', t1 = g lines env e1 in
      let e2', t2 = g lines (M.add x t env) e2 in
      (range, Let(range', (x, t), e1', e2')), t2
  | Syntax.Var(x) when M.mem x env -> (range, Var(x)), M.find x env
  | Syntax.Var(x) ->
      (match M.find x !Typing.extenv with
      | Type.Array(_) as t -> (range, ExtArray x), t
      | _ -> failwith (Printf.sprintf "external variable %s does not have an array type" x))
  | Syntax.LetRec(range', { Syntax.name = (x, t); Syntax.args = yts; Syntax.body = e1 }, e2) ->
      let env' = M.add x t env in
      let e2', t2 = g lines env' e2 in
      let e1', t1 = g lines (M.add_list yts env') e1 in
      (range, LetRec(range', { name = (x, t); args = yts; body = e1' }, e2')), t2
  | Syntax.App((_, Syntax.Var(f)), e2s) when not (M.mem f env) ->
      (match M.find f !Typing.extenv with
      | Type.Fun(_, t) ->
          let rec bind xs = function (* "xs" are identifiers for the arguments *)
            | [] -> (range, ExtFunApp(f, xs)), t
            | e2 :: e2s ->
                insert_let range (g lines env e2)
                  (fun x -> bind (xs @ [x]) e2s) in
          bind [] e2s (* left-to-right evaluation *)
      | _ -> assert false)
  | Syntax.App(e1, e2s) ->
      (match g lines env e1 with
      | _, Type.Fun(_, t) as g_e1 ->
          insert_let range g_e1
            (fun f ->
              let rec bind xs = function (* "xs" are identifiers for the arguments *)
                | [] -> (range, App(f, xs)), t
                | e2 :: e2s ->
                    insert_let range (g lines env e2)
                      (fun x -> bind (xs @ [x]) e2s) in
              bind [] e2s) (* left-to-right evaluation *)
      | _ -> assert false)
  | Syntax.Tuple(es) ->
      let rec bind xs ts = function (* "xs" and "ts" are identifiers and types for the elements *)
        | [] -> (range, Tuple(xs)), Type.Tuple(ts)
        | e :: es ->
            let _, t as g_e = g lines env e in
            insert_let range g_e
              (fun x -> bind (xs @ [x]) (ts @ [t]) es) in
      bind [] [] es
  | Syntax.LetTuple(range', xts, e1, e2) ->
      insert_let range (g lines env e1)
        (fun y ->
          let e2', t2 = g lines (M.add_list xts env) e2 in
          (range, LetTuple(range', xts, y, e2')), t2)
  | Syntax.Array(e1, e2) ->
      insert_let range (g lines env e1)
        (fun x ->
          let _, t2 as g_e2 = g lines env e2 in
          insert_let range g_e2
            (fun y ->
              let l =
                match t2 with
                | Type.Float -> "create_float_array"
                | _ -> "create_array" in
              (range, ExtFunApp(l, [x; y])), Type.Array(t2)))
  | Syntax.Get(e1, e2) ->
      (match g lines env e1 with
      |        _, Type.Array(t) as g_e1 ->
          insert_let range g_e1
            (fun x -> insert_let range (g lines env e2)
                (fun y -> (range, Get(x, y)), t))
      | _ -> assert false)
  | Syntax.Put(e1, e2, e3) ->
      insert_let range (g lines env e1)
        (fun x -> insert_let range (g lines env e2)
            (fun y -> insert_let range (g lines env e3)
                (fun z -> (range, Put(x, y, z)), Type.Unit)))
  | Syntax.Read -> (range, Read), Type.Int
  | Syntax.FRead -> (range, FRead), Type.Float
  | Syntax.Write(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, Write(x)), Type.Unit)
  | Syntax.FWrite(e) ->
      insert_let range (g lines env e)
        (fun x -> (range, FWrite(x)), Type.Unit)
  (* MATUSHITA: added polymorphic operators *)
  | Syntax.IFAdd (e1, e2) ->
      let x, t = g lines env e1 in (
      match t with
        | Type.Int ->
            insert_let range (x, t)
              (fun x -> insert_let range (g lines env e2)
                  (fun y -> (range, Add(x, y)), Type.Int))
        | Type.Float ->
            insert_let range (x, t)
              (fun x -> insert_let range (g lines env e2)
                  (fun y -> (range, FAdd(x, y)), Type.Float))
        | _ ->
            Printf.printf "Type error occurred at %s '%s': +@ is for Int or Float\n"
              (H.show_range range) (H.show_from_range lines range);
            exit 1)
  | Syntax.NotNeg e ->
      let x, t = g lines env e in (
      match t with
        | Type.Bool ->
            insert_let range (x, t)
              (fun x -> (range, Not x), Type.Bool)
        | Type.Int ->
            insert_let range (x, t)
              (fun x -> (range, Neg x), Type.Int)
        | _ ->
            Printf.printf "Type error occurred at %s '%s': -! is for Bool or Int\n"
              (H.show_range range) (H.show_from_range lines range);
            exit 1)

let f lines e = fst (g lines M.empty e)
