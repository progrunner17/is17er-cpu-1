(* type inference/reconstruction *)

open Syntax

exception Unify of Type.t * Type.t

let extenv = ref M.empty

let rec deref_typ btvs = function
  | Type.Fun(t1s, t2) -> Type.Fun(List.map (deref_typ btvs) t1s, deref_typ btvs t2)
  | Type.Tuple(ts) -> Type.Tuple(List.map (deref_typ btvs) ts)
  | Type.Array(t) -> Type.Array(deref_typ btvs t)
  | Type.Var(v) as t when List.memq v btvs -> t
  | Type.Var({contents = None, l} as v) ->
      Printf.printf "Assumed free type variable %s to be int.\n" l;
      v := Some Type.Int, l; Type.Int
  | Type.Var({contents = Some t, l} as v) ->
      let t' = deref_typ btvs t in
      v := Some t', l; t'
  | Type.Unit | Type.Bool | Type.Int | Type.Float as t -> t
  | Type.Forall (vs, t) -> Type.Forall (vs, deref_typ btvs t)
let rec deref_id_typ btvs (x, t) = (x, deref_typ btvs t)
let rec deref_exp btvs (range, body) = range, match body with
  | Not(e) -> Not(deref_exp btvs e)
  | Xor(e1, e2) -> Xor(deref_exp btvs e1, deref_exp btvs e2)
  | Neg(e) -> Neg(deref_exp btvs e)
  | Add(e1, e2) -> Add(deref_exp btvs e1, deref_exp btvs e2)
  | Sub(e1, e2) -> Sub(deref_exp btvs e1, deref_exp btvs e2)
  | SllI(e, n) -> SllI(deref_exp btvs e, n)
  | SraI(e, n) -> SraI(deref_exp btvs e, n)
  | AndI(e, n) -> AndI(deref_exp btvs e, n)
  | Eq(e1, e2) -> Eq(deref_exp btvs e1, deref_exp btvs e2)
  | LT(e1, e2) -> LT(deref_exp btvs e1, deref_exp btvs e2)
  | FNeg(e) -> FNeg(deref_exp btvs e)
  | FAbs(e) -> FAbs(deref_exp btvs e)
  | FFloor(e) -> FFloor(deref_exp btvs e)
  | IToF(e) -> IToF(deref_exp btvs e)
  | FToI(e) -> FToI(deref_exp btvs e)
  | FSqrt(e) -> FSqrt(deref_exp btvs e)
  | FCos(e) -> FCos(deref_exp btvs e)
  | FSin(e) -> FSin(deref_exp btvs e)
  | FTan(e) -> FTan(deref_exp btvs e)
  | FAtan(e) -> FAtan(deref_exp btvs e)
  | FAdd(e1, e2) -> FAdd(deref_exp btvs e1, deref_exp btvs e2)
  | FSub(e1, e2) -> FSub(deref_exp btvs e1, deref_exp btvs e2)
  | FMul(e1, e2) -> FMul(deref_exp btvs e1, deref_exp btvs e2)
  | FDiv(e1, e2) -> FDiv(deref_exp btvs e1, deref_exp btvs e2)
  | FEq(e1, e2) -> FEq(deref_exp btvs e1, deref_exp btvs e2)
  | FLT(e1, e2) -> FLT(deref_exp btvs e1, deref_exp btvs e2)
  | If(e1, e2, e3) -> If(deref_exp btvs e1, deref_exp btvs e2, deref_exp btvs e3)
  | Let(range, xt, e1, e2) -> Let(range, deref_id_typ btvs xt, deref_exp btvs e1, deref_exp btvs e2)
  | LetRec _ -> failwith "Unexpected letrec"
  | GLetRec(range, ({contents = {name = _, Type.Forall (btvs', _)} as f, []} as rfx), e) ->
      rfx := deref_fundef (btvs @ btvs') f, [];
      GLetRec(range, rfx, deref_exp btvs e)
  | GLetRec _ -> failwith "Unsupported type of gletrec"
  | App _ -> failwith "Unexpected app"
  | SApp(e, rfx, ts, es) -> SApp(deref_exp btvs e, rfx, List.map (deref_typ btvs) ts, List.map (deref_exp btvs) es)
  | Tuple(es) -> Tuple(List.map (deref_exp btvs) es)
  | LetTuple(range, xts, e1, e2) -> LetTuple(range, List.map (deref_id_typ btvs) xts, deref_exp btvs e1, deref_exp btvs e2)
  | Array(e1, e2) -> Array(deref_exp btvs e1, deref_exp btvs e2)
  | Get(e1, e2) -> Get(deref_exp btvs e1, deref_exp btvs e2)
  | Put(e1, e2, e3) -> Put(deref_exp btvs e1, deref_exp btvs e2, deref_exp btvs e3)
  | Write e -> Write (deref_exp btvs e)
  | IFAdd (e, e') -> IFAdd (deref_exp btvs e, deref_exp btvs e')
  | NotNeg e -> NotNeg (deref_exp btvs e)
  | Unit | Bool _ | Int _ | Float _ | Var _ | Read | FRead as e -> e
and deref_fundef btvs {name = xt; args = yts; body = e} = {
  name = deref_id_typ btvs xt;
  args = List.map (deref_id_typ btvs) yts;
  body = deref_exp btvs e}

(* MATSUSHITA: added functions *)
let diff xs ys = List.filter (fun x -> not (List.memq x ys)) xs
let uniq xs = List.fold_right (fun x xs -> if List.memq x xs then xs else x :: xs) (List.sort compare xs) []
let rec free_tvars = function
  | Type.Fun(t2s, t2) -> uniq (List.concat (List.map free_tvars t2s) @ free_tvars t2)
  | Type.Tuple(t2s) -> uniq (List.concat (List.map free_tvars t2s))
  | Type.Array(t2) -> free_tvars t2
  | Type.Var({contents = None, _} as v) -> [v]
  | Type.Var({contents = Some t2, _}) -> free_tvars t2
  | Type.Forall (vs, t) -> diff (free_tvars t) vs
  | Type.Unit | Type.Bool | Type.Int | Type.Float -> []
let quantify env t =
  let mtvs = M.fold (fun _ t mtvs -> uniq (free_tvars t @ mtvs)) env [] in
  Type.Forall (diff (free_tvars t) mtvs, t)
let rec subst_typ table = function
  | Type.Fun(t1s, t2) -> Type.Fun(List.map (subst_typ table) t1s, (subst_typ table) t2)
  | Type.Tuple(ts) -> Type.Tuple(List.map (subst_typ table) ts)
  | Type.Array(t) -> Type.Array(subst_typ table t)
  | Type.Var({contents = None, _} as v) -> List.assq v (table @ [(v, Type.Var v)])
  | Type.Var({contents = Some t, _}) -> subst_typ table t
  | Type.Unit | Type.Bool | Type.Int | Type.Float as t -> t
  | Type.Forall _ -> failwith "Unexpected forall"
let subst_id_typ table (oldx, newx) (x, t) = (if x = oldx then newx else x), subst_typ table t
let rec subst_exp table ((oldx, newx) as onx) (range, body) = range, match body with
  | Not(e) -> Not(subst_exp table onx e)
  | Xor(e1, e2) -> Xor(subst_exp table onx e1, subst_exp table onx e2)
  | Neg(e) -> Neg(subst_exp table onx e)
  | Add(e1, e2) -> Add(subst_exp table onx e1, subst_exp table onx e2)
  | Sub(e1, e2) -> Sub(subst_exp table onx e1, subst_exp table onx e2)
  | SllI(e, n) -> SllI(subst_exp table onx e, n)
  | SraI(e, n) -> SraI(subst_exp table onx e, n)
  | AndI(e, n) -> AndI(subst_exp table onx e, n)
  | Eq(e1, e2) -> Eq(subst_exp table onx e1, subst_exp table onx e2)
  | LT(e1, e2) -> LT(subst_exp table onx e1, subst_exp table onx e2)
  | FNeg(e) -> FNeg(subst_exp table onx e)
  | FAbs(e) -> FAbs(subst_exp table onx e)
  | FFloor(e) -> FFloor(subst_exp table onx e)
  | IToF(e) -> IToF(subst_exp table onx e)
  | FToI(e) -> FToI(subst_exp table onx e)
  | FSqrt(e) -> FSqrt(subst_exp table onx e)
  | FCos(e) -> FCos(subst_exp table onx e)
  | FSin(e) -> FSin(subst_exp table onx e)
  | FTan(e) -> FTan(subst_exp table onx e)
  | FAtan(e) -> FAtan(subst_exp table onx e)
  | FAdd(e1, e2) -> FAdd(subst_exp table onx e1, subst_exp table onx e2)
  | FSub(e1, e2) -> FSub(subst_exp table onx e1, subst_exp table onx e2)
  | FMul(e1, e2) -> FMul(subst_exp table onx e1, subst_exp table onx e2)
  | FDiv(e1, e2) -> FDiv(subst_exp table onx e1, subst_exp table onx e2)
  | FEq(e1, e2) -> FEq(subst_exp table onx e1, subst_exp table onx e2)
  | FLT(e1, e2) -> FLT(subst_exp table onx e1, subst_exp table onx e2)
  | If(e1, e2, e3) -> If(subst_exp table onx e1, subst_exp table onx e2, subst_exp table onx e3)
  | Let(range, xt, e1, e2) -> Let(range, subst_id_typ table onx xt, subst_exp table onx e1, subst_exp table onx e2)
  | LetRec(range, f, e) -> LetRec(range, subst_fundef table onx f, subst_exp table onx e)
  | GLetRec(range, ({contents = f, tsfs} as rfx), e) ->
      rfx := subst_fundef table onx f, List.map (fun (ts, f) -> List.map (subst_typ table) ts, subst_fundef table onx f) tsfs;
      GLetRec(range, rfx, subst_exp table onx e)
  | App(e, es) -> App(subst_exp table onx e, List.map (subst_exp table onx) es)
  | SApp(e, rfx, ts, es) -> SApp(subst_exp table onx e, rfx, List.map (subst_typ table) ts, List.map (subst_exp table onx) es)
  | Tuple(es) -> Tuple(List.map (subst_exp table onx) es)
  | LetTuple(range, xts, e1, e2) -> LetTuple(range, List.map (subst_id_typ table onx) xts, subst_exp table onx e1, subst_exp table onx e2)
  | Array(e1, e2) -> Array(subst_exp table onx e1, subst_exp table onx e2)
  | Get(e1, e2) -> Get(subst_exp table onx e1, subst_exp table onx e2)
  | Put(e1, e2, e3) -> Put(subst_exp table onx e1, subst_exp table onx e2, subst_exp table onx e3)
  | Write e -> Write (subst_exp table onx e)
  | IFAdd (e, e') -> IFAdd (subst_exp table onx e, subst_exp table onx e')
  | NotNeg e -> NotNeg (subst_exp table onx e)
  | Var x -> Var (if x = oldx then newx else x)
  | Unit | Bool _ | Int _ | Float _ | Read | FRead as e -> e
and subst_fundef table onx {name = xt; args = yts; body = e} = {
  name = subst_id_typ table onx xt;
  args = List.map (subst_id_typ table onx) yts;
  body = subst_exp table onx e}
let dequantify = function
  | Type.Forall (vs, t) ->
      let table = List.map (fun v -> (v, Type.gentyp ())) vs in
      List.map snd table, subst_typ table t
  | t -> [], t

let rec occur var1 = function (* occur check (caml2html: typing_occur) *)
  | Type.Fun(t2s, t2) -> List.exists (occur var1) t2s || occur var1 t2
  | Type.Tuple(t2s) -> List.exists (occur var1) t2s
  | Type.Array(t2) -> occur var1 t2
  | Type.Var(var2) when var1 == var2 -> true
  | Type.Var({contents = None, _}) -> false
  | Type.Var({contents = Some t2, _}) -> occur var1 t2
  | _ -> false

let rec unify t1 t2 = (* 型が合うように、型変数への代入をする (caml2html: typing_unify) *)
  match t1, t2 with
  | Type.Unit, Type.Unit | Type.Bool, Type.Bool | Type.Int, Type.Int | Type.Float, Type.Float -> ()
  | Type.Fun(t1s, t1'), Type.Fun(t2s, t2') ->
      (try List.iter2 unify t1s t2s
      with Invalid_argument(_) -> raise (Unify(t1, t2)));
      unify t1' t2'
  | Type.Tuple(t1s), Type.Tuple(t2s) ->
      (try List.iter2 unify t1s t2s
      with Invalid_argument(_) -> raise (Unify(t1, t2)))
  | Type.Array(t1), Type.Array(t2) -> unify t1 t2
  | Type.Var(var1), Type.Var(var2) when var1 == var2 -> ()
  | Type.Var({contents = Some t1', _}), _ -> unify t1' t2
  | _, Type.Var({contents = Some t2', _}) -> unify t1 t2'
  | Type.Var({contents = None, l1} as v1), _ -> (* 一方が未定義の型変数の場合 (caml2html: typing_undef) *)
      if occur v1 t2 then raise (Unify(t1, t2));
      v1 := Some t2, l1;
  | _, Type.Var({contents = None, l2} as v2) ->
      if occur v2 t1 then raise (Unify(t1, t2));
      v2 := Some t1, l2;
  | _, _ -> raise (Unify(t1, t2))

let rec g lines env fenv ((range, body) as e) = (* 型推論ルーチン (caml2html: typing_g) *)
  try
    match body with
    | Unit -> Type.Unit, e
    | Bool _ -> Type.Bool, e
    | Int _ -> Type.Int, e
    | Float _ -> Type.Float, e
    | Not e ->
        let t, e = g lines env fenv e in
        unify Type.Bool t;
        Type.Bool, (range, Not e)
    | Xor (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Bool t1; unify Type.Bool t2;
        Type.Bool, (range, Xor (e1, e2))
    | Neg e ->
        let t, e = g lines env fenv e in
        unify Type.Int t;
        Type.Int, (range, Neg e)
    | SllI (e, n) ->
        let t, e = g lines env fenv e in
        unify Type.Int t;
        Type.Int, (range, SllI (e, n))
    | SraI (e, n) ->
        let t, e = g lines env fenv e in
        unify Type.Int t;
        Type.Int, (range, SraI (e, n))
    | AndI (e, n) ->
        let t, e = g lines env fenv e in
        unify Type.Int t;
        Type.Int, (range, AndI (e, n))
    | Add (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Int t1;
        unify Type.Int t2;
        Type.Int, (range, Add (e1, e2))
    | Sub (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Int t1; unify Type.Int t2;
        Type.Int, (range, Sub (e1, e2))
    | Eq(e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Int t1; unify Type.Int t2;
        Type.Bool, (range, Eq(e1, e2))
    | LT(e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Int t1; unify Type.Int t2;
        Type.Bool, (range, LT(e1, e2))
    | FNeg e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Float, (range, FNeg e)
    | FAbs e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Float, (range, FAbs e)
    | FFloor e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Float, (range, FFloor e)
    | FSqrt e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Float, (range, FSqrt e)
    | FCos e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Float, (range, FCos e)
    | FSin e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Float, (range, FSin e)
    | FTan e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Float, (range, FTan e)
    | FAtan e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Float, (range, FAtan e)
    | IToF e ->
        let t, e = g lines env fenv e in
        unify Type.Int t;
        Type.Float, (range, IToF e)
    | FToI e ->
        let t, e = g lines env fenv e in
        unify Type.Float t;
        Type.Int, (range, FToI e)
    | FAdd (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Float t1; unify Type.Float t2;
        Type.Float, (range, FAdd (e1, e2))
    | FSub (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Float t1; unify Type.Float t2;
        Type.Float, (range, FSub (e1, e2))
    | FMul (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Float t1; unify Type.Float t2;
        Type.Float, (range, FMul (e1, e2))
    | FDiv (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Float t1; unify Type.Float t2;
        Type.Float, (range, FDiv (e1, e2))
    | FEq (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Float t1; unify Type.Float t2;
        Type.Bool, (range, FEq (e1, e2))
    | FLT (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify Type.Float t1; unify Type.Float t2;
        Type.Bool, (range, FLT (e1, e2))
    | If (e1, e2, e3) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        let t3, e3 = g lines env fenv e3 in
        unify Type.Bool t1; unify t2 t3;
        t2, (range, If (e1, e2, e3))
    | Let (range', (x, t), e1, e2) -> (* letの型推論 (caml2html: typing_let) *)
        let t1, e1 = g lines env fenv e1 in
        unify t t1;
        let t2, e2 = g lines (M.add x t1 env) fenv e2 in
        t2, (range, Let (range', (x, t1), e1, e2))
    | Var x when M.mem x env -> M.find x env, e (* 変数の型推論 (caml2html: typing_var) *)
    | Var x when M.mem x !extenv -> M.find x !extenv, e
    | Var x -> (* 外部変数の型推論 (caml2html: typing_extvar) *)
        Printf.printf "Assumed free variable %s to be external.%s" x (H.down ());
        let t = Type.gentyp () in
        extenv := M.add x t !extenv;
        t, e
    | LetRec(range', {name = (x, t); args = yts; body = e1}, e2) -> (* let recの型推論 (caml2html: typing_letrec) *)
        let t1, e1 = g lines (M.add_list yts (M.add x t env)) fenv e1 in
        unify t (Type.Fun(List.map snd yts, t1));
        let t = quantify env t in
        let rfx = ref ({name = (x, t); args = yts; body = e1}, []) in
        let t2, e2 = g lines (M.add x t env) (M.add x rfx fenv) e2 in
        t2, (range, GLetRec(range', rfx, e2))
    | GLetRec _ -> failwith "Unexpected gletrec"
    | App ((_, Var x) as e, es) -> (* 関数適用の型推論 (caml2html: typing_app) *)
        let rt = Type.gentyp () in
        let t, e = g lines env fenv e in
        let ts, t = dequantify t in
        let tes = List.map (g lines env fenv) es in
        unify t (Type.Fun (List.map fst tes, rt));
        rt, (range, SApp (e, (try Some (M.find x fenv) with Not_found -> None), ts, List.map snd tes))
    | App _ -> failwith "Unsupported type of app"
    | SApp _ -> failwith "Unexpected sapp"
    | Tuple es ->
        let tes = List.map (g lines env fenv) es in
        Type.Tuple (List.map fst tes), (range, Tuple (List.map snd tes))
    | LetTuple (range', xts, e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        unify (Type.Tuple (List.map snd xts)) t1;
        let t2, e2 = g lines (M.add_list xts env) fenv e2 in
        t2, (range, LetTuple (range', xts, e1, e2))
    | Array (e1, e2) -> (* must be a primitive for "polymorphic" typing *)
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify t1 Type.Int;
        Type.Array t2, (range, Array (e1, e2))
    | Get (e1, e2) ->
        let t = Type.gentyp () in
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify (Type.Array t) t1; unify Type.Int t2;
        t, (range, Get (e1, e2))
    | Put (e1, e2, e3) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        let t3, e3 = g lines env fenv e3 in
        unify (Type.Array t3) t1; unify Type.Int t2;
        Type.Unit, (range, Put (e1, e2, e3))
    | Read -> Type.Int, e
    | FRead -> Type.Float, e
    | Write e ->
        let t, e = g lines env fenv e in
        unify Type.Int t;
        Type.Unit, (range, Write e)
    (* MATUSHITA: added polymorphic operators *)
    | IFAdd (e1, e2) ->
        let t1, e1 = g lines env fenv e1 in
        let t2, e2 = g lines env fenv e2 in
        unify t1 t2;
        t1, (range, IFAdd (e1, e2))
    | NotNeg e ->
        let t, e = g lines env fenv e in
        t, (range, NotNeg e)
  with Unify(t1, t2) ->
    (* MATSUSHITA: modified error message *)
    Printf.printf "Type unification error occurred at %s '%s': conflict between %s and %s\n"
      (H.show_range range) (H.show_from_range lines range) (Type.show t1) (Type.show t2);
    exit 1

(* MATSUSHITA: added functions *)
let rec expand (range, body) = range, match body with
  | Not(e) -> Not(expand e)
  | Xor(e1, e2) -> Xor(expand e1, expand e2)
  | Neg(e) -> Neg(expand e)
  | Add(e1, e2) -> Add(expand e1, expand e2)
  | Sub(e1, e2) -> Sub(expand e1, expand e2)
  | SllI(e, n) -> SllI(expand e, n)
  | SraI(e, n) -> SraI(expand e, n)
  | AndI(e, n) -> AndI(expand e, n)
  | Eq(e1, e2) -> Eq(expand e1, expand e2)
  | LT(e1, e2) -> LT(expand e1, expand e2)
  | FNeg(e) -> FNeg(expand e)
  | FAbs(e) -> FAbs(expand e)
  | FFloor(e) -> FFloor(expand e)
  | IToF(e) -> IToF(expand e)
  | FToI(e) -> FToI(expand e)
  | FSqrt(e) -> FSqrt(expand e)
  | FCos(e) -> FCos(expand e)
  | FSin(e) -> FSin(expand e)
  | FTan(e) -> FTan(expand e)
  | FAtan(e) -> FAtan(expand e)
  | FAdd(e1, e2) -> FAdd(expand e1, expand e2)
  | FSub(e1, e2) -> FSub(expand e1, expand e2)
  | FMul(e1, e2) -> FMul(expand e1, expand e2)
  | FDiv(e1, e2) -> FDiv(expand e1, expand e2)
  | FEq(e1, e2) -> FEq(expand e1, expand e2)
  | FLT(e1, e2) -> FLT(expand e1, expand e2)
  | If(e1, e2, e3) -> If(expand e1, expand e2, expand e3)
  | Let(range, xt, e1, e2) -> Let(range, xt, expand e1, expand e2)
  | LetRec(range, f, e) -> failwith "Unexpected letrec"
  | GLetRec(range, ({contents = f, tsfs} as rfx), e) ->
      rfx := f, List.map (fun (ts, f) -> ts, expand_fundef f) tsfs;
      GLetRec(range, rfx, expand e)
  | App(e, es) -> failwith "Unexpected app"
  | SApp((range, Var x), None, [], es) ->
      App((range, Var x), List.map expand es)
  | SApp((range, Var x), Some ({contents = {name = _, Type.Forall (vs, t); args = yts; body = e} as f, tsfs} as rfx), ts, es) ->
      let x = try
        fst (List.assoc ts tsfs).name
      with Not_found ->
        let newx = if ts = [] then x else x^"{"^H.sep ";" Type.show ts^"}" in
        let table = List.map2 (fun v t -> v, t) vs ts in
        let onx = x, newx in
        let newf = {name = newx, subst_typ table t; args = List.map (subst_id_typ table onx) yts; body = expand (subst_exp table onx e)} in
        rfx := f, tsfs @ [(ts, newf)];
        newx in
      App((range, Var x), List.map expand es)
  | SApp _ -> failwith "Unsupported type of sapp"
  | Tuple(es) -> Tuple(List.map expand es)
  | LetTuple(range, xts, e1, e2) -> LetTuple(range, xts, expand e1, expand e2)
  | Array(e1, e2) -> Array(expand e1, expand e2)
  | Get(e1, e2) -> Get(expand e1, expand e2)
  | Put(e1, e2, e3) -> Put(expand e1, expand e2, expand e3)
  | Write e -> Write (expand e)
  | IFAdd (e, e') -> IFAdd (expand e, expand e')
  | NotNeg e -> NotNeg (expand e)
  | Unit | Bool _ | Int _ | Float _ | Var _ | Read | FRead as e -> e
and expand_fundef {name = xt; args = yts; body = e} = {name = xt; args = yts; body = expand e}
let rec clean (range, body) = range, match body with
  | Not(e) -> Not(clean e)
  | Xor(e1, e2) -> Xor(clean e1, clean e2)
  | Neg(e) -> Neg(clean e)
  | Add(e1, e2) -> Add(clean e1, clean e2)
  | Sub(e1, e2) -> Sub(clean e1, clean e2)
  | SllI(e, n) -> SllI(clean e, n)
  | SraI(e, n) -> SraI(clean e, n)
  | AndI(e, n) -> AndI(clean e, n)
  | Eq(e1, e2) -> Eq(clean e1, clean e2)
  | LT(e1, e2) -> LT(clean e1, clean e2)
  | FNeg(e) -> FNeg(clean e)
  | FAbs(e) -> FAbs(clean e)
  | FFloor(e) -> FFloor(clean e)
  | IToF(e) -> IToF(clean e)
  | FToI(e) -> FToI(clean e)
  | FSqrt(e) -> FSqrt(clean e)
  | FCos(e) -> FCos(clean e)
  | FSin(e) -> FSin(clean e)
  | FTan(e) -> FTan(clean e)
  | FAtan(e) -> FAtan(clean e)
  | FAdd(e1, e2) -> FAdd(clean e1, clean e2)
  | FSub(e1, e2) -> FSub(clean e1, clean e2)
  | FMul(e1, e2) -> FMul(clean e1, clean e2)
  | FDiv(e1, e2) -> FDiv(clean e1, clean e2)
  | FEq(e1, e2) -> FEq(clean e1, clean e2)
  | FLT(e1, e2) -> FLT(clean e1, clean e2)
  | If(e1, e2, e3) -> If(clean e1, clean e2, clean e3)
  | Let(range, xt, e1, e2) -> Let(range, xt, clean e1, clean e2)
  | LetRec _ -> failwith "Unexpected letrec"
  | GLetRec(range', {contents = f, tsfs}, e) ->
      snd (List.fold_right (fun (_, f) e -> range, LetRec (range', f, e)) tsfs (clean e))
  | App(e, es) -> App(clean e, List.map clean es)
  | SApp _ -> failwith "Unexpected sapp"
  | Tuple(es) -> Tuple(List.map clean es)
  | LetTuple(range, xts, e1, e2) -> LetTuple(range, xts, clean e1, clean e2)
  | Array(e1, e2) -> Array(clean e1, clean e2)
  | Get(e1, e2) -> Get(clean e1, clean e2)
  | Put(e1, e2, e3) -> Put(clean e1, clean e2, clean e3)
  | Write e -> Write (clean e)
  | IFAdd (e, e') -> IFAdd (clean e, clean e')
  | NotNeg e -> NotNeg (clean e)
  | Unit | Bool _ | Int _ | Float _ | Var _ | Read | FRead as e -> e
and clean_fundef {name = xt; args = yts; body = e} = {name = xt; args = yts; body = clean e}

let f lines e =
  extenv := M.empty;
  try
    let t, e = g lines M.empty M.empty e in
    unify Type.Unit t;
    extenv := M.map (deref_typ []) !extenv;
    let e = deref_exp [] e in
    let e = expand e in
    clean e
  with Unify _ -> failwith "Top level does not have type unit"
