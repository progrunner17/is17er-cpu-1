open KNormal

(* MATSUSHITA: removed function effect *)

(* プログラムから副作用を持ちうる関数の集合を得る *)
let get_ffs e =
  let ffs = ref S.empty in
  let register preffs xs =
    if List.exists (fun x -> S.mem x !ffs || S.mem x preffs) xs then
      S.iter (fun x -> ffs := S.add x !ffs) preffs in
  let rec go preffs (_, body) = match body with
    | IfEq (_, _, _, e, e') | IfLE (_, _, _, e, e') | Let (_, _, e, e') -> go preffs e; go preffs e'
    | Var x -> register preffs [x]
    | LetRec (_, { name = x, _; body = e }, e') -> go (S.add x preffs) e; go preffs e'
    | App (x, xs) -> register preffs (x :: xs)
    | Tuple xs -> register preffs xs
    | LetTuple (_, _, _, e) -> go preffs e
    | Put _ | ExtFunApp _ -> S.iter (fun x -> ffs := S.add x !ffs) preffs
    | _ -> () in
  go S.empty e;
  !ffs

(* 部分式が副作用を持ちうるかどうか *)
let rec effect ffs (_, body) = match body with
  | IfEq (_, _, _, e1, e2) | IfLE (_, _, _, e1, e2) | Let (_, _, e1, e2) -> effect ffs e1 || effect ffs e2
  | Var x -> S.mem x ffs
  | LetRec (_, _, e) | LetTuple (_, _, _, e) -> effect ffs e
  | App (x, xs) -> List.exists (fun x -> S.mem x ffs) (x :: xs)
  | Tuple xs -> List.exists (fun x -> S.mem x ffs) xs
  | Put _ | ExtFunApp _ -> true
  | _ -> false

let rec g ffs (range, body) = match body with
  | IfEq(range', x, y, e1, e2) -> range, IfEq(range', x, y, g ffs e1, g ffs e2)
  | IfLE(range', x, y, e1, e2) -> range, IfLE(range', x, y, g ffs e1, g ffs e2)
  | Let(range', (x, t), e1, e2) -> (* letの場合 (caml2html: elim_let) *)
      let e1' = g ffs e1 in
      let e2' = g ffs e2 in
      if effect ffs e1' || S.mem x (fv e2') then range, Let(range', (x, t), e1', e2') else
      (Printf.printf "Eliminating variable %s\n" x;
       e2')
  | LetRec(range', { name = (x, t); args = yts; body = e1 }, e2) -> (* let recの場合 (caml2html: elim_letrec) *)
      let e2' = g ffs e2 in
      if S.mem x (fv e2') then
        range, LetRec(range', { name = (x, t); args = yts; body = g ffs e1 }, e2')
      else
        (Printf.printf "Eliminating function %s\n" x;
         e2')
  | LetTuple(range', xts, y, e) ->
      let xs = List.map fst xts in
      let e' = g ffs e in
      let live = fv e' in
      if List.exists (fun x -> S.mem x live) xs then range, LetTuple(range', xts, y, e') else
      (Printf.printf "Eliminating variables %s" (Id.pp_list xs);
       e')
  | _ -> range, body

let f e = g (get_ffs e) e
