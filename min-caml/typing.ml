(* type inference/reconstruction *)

open Syntax

exception Unify of Type.t * Type.t

let extenv = ref M.empty

(* for pretty printing (and type normalization) *)
let rec deref_typ = function (* 型変数を中身でおきかえる関数 (caml2html: typing_deref) *)
  | Type.Fun(t1s, t2) -> Type.Fun(List.map deref_typ t1s, deref_typ t2)
  | Type.Tuple(ts) -> Type.Tuple(List.map deref_typ ts)
  | Type.Array(t) -> Type.Array(deref_typ t)
  | Type.Var({ contents = None } as r) ->
      Printf.printf "Uninstantiated type variable detected; assuming int\n";
      r := Some(Type.Int);
      Type.Int
  | Type.Var({ contents = Some(t) } as r) ->
      let t' = deref_typ t in
      r := Some(t');
      t'
  | Type.Unit | Type.Bool | Type.Int | Type.Float as t -> t
let rec deref_id_typ (x, t) = (x, deref_typ t)
let rec deref_term (range, body) = range, match body with
  | Not(e) -> Not(deref_term e)
  | Xor(e1, e2) -> Xor(deref_term e1, deref_term e2)
  | Neg(e) -> Neg(deref_term e)
  | Add(e1, e2) -> Add(deref_term e1, deref_term e2)
  | Sub(e1, e2) -> Sub(deref_term e1, deref_term e2)
  | SllI(e, n) -> SllI(deref_term e, n)
  | SraI(e, n) -> SraI(deref_term e, n)
  | AndI(e, n) -> AndI(deref_term e, n)
  | Eq(e1, e2) -> Eq(deref_term e1, deref_term e2)
  | LT(e1, e2) -> LT(deref_term e1, deref_term e2)
  | FNeg(e) -> FNeg(deref_term e)
  | FAbs(e) -> FAbs(deref_term e)
  | FFloor(e) -> FFloor(deref_term e)
  | IToF(e) -> IToF(deref_term e)
  | FToI(e) -> FToI(deref_term e)
  | FSqrt(e) -> FSqrt(deref_term e)
  | FCos(e) -> FCos(deref_term e)
  | FSin(e) -> FSin(deref_term e)
  | FTan(e) -> FTan(deref_term e)
  | FAtan(e) -> FAtan(deref_term e)
  | FAdd(e1, e2) -> FAdd(deref_term e1, deref_term e2)
  | FSub(e1, e2) -> FSub(deref_term e1, deref_term e2)
  | FMul(e1, e2) -> FMul(deref_term e1, deref_term e2)
  | FDiv(e1, e2) -> FDiv(deref_term e1, deref_term e2)
  | FEq(e1, e2) -> FEq(deref_term e1, deref_term e2)
  | FLT(e1, e2) -> FLT(deref_term e1, deref_term e2)
  | If(e1, e2, e3) -> If(deref_term e1, deref_term e2, deref_term e3)
  | Let(range, xt, e1, e2) -> Let(range, deref_id_typ xt, deref_term e1, deref_term e2)
  | LetRec(range, { name = xt; args = yts; body = e1 }, e2) ->
      LetRec(range,
       { name = deref_id_typ xt;
         args = List.map deref_id_typ yts;
         body = deref_term e1 },
             deref_term e2)
  | App(e, es) -> App(deref_term e, List.map deref_term es)
  | Tuple(es) -> Tuple(List.map deref_term es)
  | LetTuple(range, xts, e1, e2) -> LetTuple(range, List.map deref_id_typ xts, deref_term e1, deref_term e2)
  | Array(e1, e2) -> Array(deref_term e1, deref_term e2)
  | Get(e1, e2) -> Get(deref_term e1, deref_term e2)
  | Put(e1, e2, e3) -> Put(deref_term e1, deref_term e2, deref_term e3)
  | Write e -> Write (deref_term e)
  | FWrite e -> FWrite (deref_term e)
  | Unit | Bool _ | Int _ | Float _ | Var _ | Read | FRead as e -> e

let rec occur r1 = function (* occur check (caml2html: typing_occur) *)
  | Type.Fun(t2s, t2) -> List.exists (occur r1) t2s || occur r1 t2
  | Type.Tuple(t2s) -> List.exists (occur r1) t2s
  | Type.Array(t2) -> occur r1 t2
  | Type.Var(r2) when r1 == r2 -> true
  | Type.Var({ contents = None }) -> false
  | Type.Var({ contents = Some(t2) }) -> occur r1 t2
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
  | Type.Var(r1), Type.Var(r2) when r1 == r2 -> ()
  | Type.Var({ contents = Some(t1') }), _ -> unify t1' t2
  | _, Type.Var({ contents = Some(t2') }) -> unify t1 t2'
  | Type.Var({ contents = None } as r1), _ -> (* 一方が未定義の型変数の場合 (caml2html: typing_undef) *)
      if occur r1 t2 then raise (Unify(t1, t2));
      r1 := Some(t2)
  | _, Type.Var({ contents = None } as r2) ->
      if occur r2 t1 then raise (Unify(t1, t2));
      r2 := Some(t1)
  | _, _ -> raise (Unify(t1, t2))

let rec g lines env ((range, body) as e) = (* 型推論ルーチン (caml2html: typing_g) *)
  try
    match body with
    | Unit -> Type.Unit
    | Bool(_) -> Type.Bool
    | Int(_) -> Type.Int
    | Float(_) -> Type.Float
    | Not(e) ->
        unify Type.Bool (g lines env e);
        Type.Bool
    | Xor(e1, e2) ->
        unify Type.Bool (g lines env e1);
        unify Type.Bool (g lines env e2);
        Type.Bool
    | Neg(e) | SllI(e, _) | SraI(e, _) | AndI(e, _) ->
        unify Type.Int (g lines env e);
        Type.Int
    | Add(e1, e2) | Sub(e1, e2) ->
        unify Type.Int (g lines env e1);
        unify Type.Int (g lines env e2);
        Type.Int
    | Eq(e1, e2) | LT(e1, e2) ->
        unify Type.Int (g lines env e1);
        unify Type.Int (g lines env e2);
        Type.Bool
    | FNeg(e) | FAbs(e) | FFloor(e) | FSqrt(e) | FCos(e) | FSin(e) | FTan(e) | FAtan(e) ->
        unify Type.Float (g lines env e);
        Type.Float
    | IToF(e) ->
        unify Type.Int (g lines env e);
        Type.Float
    | FToI(e) ->
        unify Type.Float (g lines env e);
        Type.Int
    | FAdd(e1, e2) | FSub(e1, e2) | FMul(e1, e2) | FDiv(e1, e2) ->
        unify Type.Float (g lines env e1);
        unify Type.Float (g lines env e2);
        Type.Float
    | FEq(e1, e2) | FLT(e1, e2) ->
        unify Type.Float (g lines env e1);
        unify Type.Float (g lines env e2);
        Type.Bool
    | If(e1, e2, e3) ->
        unify (g lines env e1) Type.Bool;
        let t2 = g lines env e2 in
        let t3 = g lines env e3 in
        unify t2 t3;
        t2
    | Let(_, (x, t), e1, e2) -> (* letの型推論 (caml2html: typing_let) *)
        unify t (g lines env e1);
        g lines (M.add x t env) e2
    | Var(x) when M.mem x env -> M.find x env (* 変数の型推論 (caml2html: typing_var) *)
    | Var(x) when M.mem x !extenv -> M.find x !extenv
    | Var(x) -> (* 外部変数の型推論 (caml2html: typing_extvar) *)
        Printf.printf "Free variable %s assumed as external\n" x;
        let t = Type.gentyp () in
        extenv := M.add x t !extenv;
        t
    | LetRec(_, { name = (x, t); args = yts; body = e1 }, e2) -> (* let recの型推論 (caml2html: typing_letrec) *)
        let env = M.add x t env in
        unify t (Type.Fun(List.map snd yts, g lines (M.add_list yts env) e1));
        g lines env e2
    | App(e, es) -> (* 関数適用の型推論 (caml2html: typing_app) *)
        let t = Type.gentyp () in
        unify (g lines env e) (Type.Fun(List.map (g lines env) es, t));
        t
    | Tuple(es) -> Type.Tuple(List.map (g lines env) es)
    | LetTuple(_, xts, e1, e2) ->
        unify (Type.Tuple(List.map snd xts)) (g lines env e1);
        g lines (M.add_list xts env) e2
    | Array(e1, e2) -> (* must be a primitive for "polymorphic" typing *)
        unify (g lines env e1) Type.Int;
        Type.Array(g lines env e2)
    | Get(e1, e2) ->
        let t = Type.gentyp () in
        unify (Type.Array(t)) (g lines env e1);
        unify Type.Int (g lines env e2);
        t
    | Put(e1, e2, e3) ->
        let t = g lines env e3 in
        unify (Type.Array(t)) (g lines env e1);
        unify Type.Int (g lines env e2);
        Type.Unit
    | Read -> Type.Int
    | FRead -> Type.Float
    | Write e ->
        unify Type.Int (g lines env e);
        Type.Unit
    | FWrite e ->
        unify Type.Float (g lines env e);
        Type.Unit
  with Unify(t1, t2) -> let e' = deref_term e in
    (* MATSUSHITA: modified error message *)
    Printf.printf "Type unification error occurred at %s '%s': conflict between %s and %s\n"
      (H.show_range range) (H.show_from_range lines (fst e')) (Type.show (deref_typ t1)) (Type.show (deref_typ t2));
    exit 1

let f lines e =
  extenv := M.empty;
  (try unify Type.Unit (g lines M.empty e)
  with Unify _ -> failwith "top level does not have type unit");
  extenv := M.map deref_typ !extenv;
  deref_term e
