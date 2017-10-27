open Asm
open Lexing

external gethi : float -> int32 = "gethi"
external getlo : float -> int32 = "getlo"

(* MATSUSHITA: added functions comment_range and comment_range' *)

let comment_range lines range = match range with
  | None -> ""
  | _ -> "\t# "^H.show_from_range lines range

let comment_range' lines range = match range with
  | None -> ""
  | _ -> "\t"^H.show_from_range lines range

let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)
let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)
let save x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let savef x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    (let pad =
      if List.length !stackmap mod 2 = 0 then [] else [Id.genid "paddingint"] in
    stackmap := !stackmap @ pad @ [x; x])
let locate x =
  let rec loc = function
    | [] -> []
    | y :: zs when x = y -> 0 :: List.map succ (loc zs)
    | y :: zs -> List.map succ (loc zs) in
  loc !stackmap
let offset x = 4 * List.hd (locate x)
let stacksize () = align ((List.length !stackmap + 1) * 4)

let reg r =
  if is_reg r
  then String.sub r 1 (String.length r - 1)
  else r

(* MATSUSHITA: added range comments *)
let load_label range lines r label =
  let r' = reg r in
  Printf.sprintf
    "\tlis\t%s, ha16(%s)%s\n\taddi\t%s, %s, lo16(%s)%s\n"
    r' label (comment_range lines range) r' r' label (comment_range lines range)

(* 関数呼び出しのために引数を並べ替える(register shuffling) (caml2html: emit_shuffle) *)
let rec shuffle sw xys =
  (* remove identical moves *)
  let _, xys = List.partition (fun (x, y) -> x = y) xys in
  (* find acyclic moves *)
  match List.partition (fun (_, y) -> List.mem_assoc y xys) xys with
  | [], [] -> []
  | (x, y) :: xys, [] -> (* no acyclic moves; resolve a cyclic move *)
      (y, sw) :: (x, y) :: shuffle sw (List.map
                                         (function
                                           | (y', z) when y = y' -> (sw, z)
                                           | yz -> yz)
                                         xys)
  | xys, acyc -> acyc @ shuffle sw xys

type dest = Tail | NonTail of Id.t (* 末尾かどうかを表すデータ型 (caml2html: emit_dest) *)
let rec g oc lines (dest, (_, body)) = match body with (* 命令列のアセンブリ生成 (caml2html: emit_g) *)
  | Ans(exp) -> g' oc lines (dest, exp)
  | Let(range', (x, t), exp, e) ->
      g' oc lines (NonTail(x), exp);
      g oc lines (dest, e)
(* MATSUSHITA: added range comments *)
and g' oc lines (dest, ((range, body) as exp)) = match (dest, body) with (* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  | NonTail(_), Nop -> ()
  | NonTail(x), Li(i) when -32768 <= i && i < 32768 -> Printf.fprintf oc "\tli\t%s, %d%s\n" (reg x) i (comment_range lines range)
  | NonTail(x), Li(i) ->
      let n = i lsr 16 in
      let m = i lxor (n lsl 16) in
      let r = reg x in
      Printf.fprintf oc "\tlis\t%s, %d%s\n" r n (comment_range lines range);
      Printf.fprintf oc "\tori\t%s, %s, %d%s\n" r r m (comment_range lines range)
  | NonTail(x), FLi(Id.L(l)) ->
      let s = load_label range lines (reg reg_tmp) l in
      Printf.fprintf oc "%s\tlfd\t%s, 0(%s)%s\n" s (reg x) (reg reg_tmp) (comment_range lines range)
  | NonTail(x), SetL(Id.L(y)) ->
      let s = load_label range lines x y in
      Printf.fprintf oc "%s" s
  | NonTail(x), Mr(y) when x = y -> ()
  | NonTail(x), Mr(y) -> Printf.fprintf oc "\tmr\t%s, %s%s\n" (reg x) (reg y) (comment_range lines range)
  | NonTail(x), Neg(y) -> Printf.fprintf oc "\tneg\t%s, %s%s\n" (reg x) (reg y) (comment_range lines range)
  | NonTail(x), Add(y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), Add(y, C(z)) -> Printf.fprintf oc "\taddi\t%s, %s, %d%s\n" (reg x) (reg y) z (comment_range lines range)
  | NonTail(x), Sub(y, V(z)) -> Printf.fprintf oc "\tsub\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), Sub(y, C(z)) -> Printf.fprintf oc "\tsubi\t%s, %s, %d%s\n" (reg x) (reg y) z (comment_range lines range)
  | NonTail(x), Slw(y, V(z)) -> Printf.fprintf oc "\tslw\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), Slw(y, C(z)) -> Printf.fprintf oc "\tslwi\t%s, %s, %d%s\n" (reg x) (reg y) z (comment_range lines range)
  | NonTail(x), Lwz(y, V(z)) -> Printf.fprintf oc "\tlwzx\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), Lwz(y, C(z)) -> Printf.fprintf oc "\tlwz\t%s, %d(%s)%s\n" (reg x) z (reg y) (comment_range lines range)
  | NonTail(_), Stw(x, y, V(z)) -> Printf.fprintf oc "\tstwx\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(_), Stw(x, y, C(z)) -> Printf.fprintf oc "\tstw\t%s, %d(%s)%s\n" (reg x) z (reg y) (comment_range lines range)
  | NonTail(x), FMr(y) when x = y -> ()
  | NonTail(x), FMr(y) -> Printf.fprintf oc "\tfmr\t%s, %s%s\n" (reg x) (reg y) (comment_range lines range)
  | NonTail(x), FNeg(y) -> Printf.fprintf oc "\tfneg\t%s, %s%s\n" (reg x) (reg y) (comment_range lines range)
  | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\tfadd\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\tfsub\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\tfmul\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), FDiv(y, z) -> Printf.fprintf oc "\tfdiv\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), Lfd(y, V(z)) -> Printf.fprintf oc "\tlfdx\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), Lfd(y, C(z)) -> Printf.fprintf oc "\tlfd\t%s, %d(%s)%s\n" (reg x) z (reg y) (comment_range lines range)
  | NonTail(_), Stfd(x, y, V(z)) -> Printf.fprintf oc "\tstfdx\t%s, %s, %s%s\n" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(_), Stfd(x, y, C(z)) -> Printf.fprintf oc "\tstfd\t%s, %d(%s)%s\n" (reg x) z (reg y) (comment_range lines range)
  | NonTail(_), Comment(s) -> Printf.fprintf oc "#\t%s\n" s
  (* 退避の仮想命令の実装 (caml2html: emit_save) *)
  | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y;
      Printf.fprintf oc "\tstw\t%s, %d(%s)%s\n" (reg x) (offset y) (reg reg_sp) (comment_range lines range)
  | NonTail(_), Save(x, y) when List.mem x allfregs && not (S.mem y !stackset) ->
      savef y;
      Printf.fprintf oc "\tstfd\t%s, %d(%s)%s\n" (reg x) (offset y) (reg reg_sp) (comment_range lines range)
  | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); ()
  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
  | NonTail(x), Restore(y) when List.mem x allregs ->
      Printf.fprintf oc "\tlwz\t%s, %d(%s)%s\n" (reg x) (offset y) (reg reg_sp) (comment_range lines range)
  | NonTail(x), Restore(y) ->
      assert (List.mem x allfregs);
      Printf.fprintf oc "\tlfd\t%s, %d(%s)%s\n" (reg x) (offset y) (reg reg_sp) (comment_range lines range)
  (* 末尾だったら計算結果を第一レジスタにセットしてリターン (caml2html: emit_tailret) *)
  | Tail, (Nop | Stw _ | Stfd _ | Comment _ | Save _) ->
      g' oc lines (NonTail(Id.genunit ()), exp);
      Printf.fprintf oc "\tblr%s\n" (comment_range lines range);
  | Tail, (Li _ | SetL _ | Mr _ | Neg _ | Add _ | Sub _ | Slw _ | Lwz _) ->
      g' oc lines (NonTail(regs.(0)), exp);
      Printf.fprintf oc "\tblr%s\n" (comment_range lines range);
  | Tail, (FLi _ | FMr _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ | Lfd _) ->
      g' oc lines (NonTail(fregs.(0)), exp);
      Printf.fprintf oc "\tblr%s\n" (comment_range lines range);
  | Tail, Restore(x) ->
      (match locate x with
      | [i] -> g' oc lines (NonTail(regs.(0)), exp)
      | [i; j] when i + 1 = j -> g' oc lines (NonTail(fregs.(0)), exp)
      | _ -> assert false);
      Printf.fprintf oc "\tblr%s\n" (comment_range lines range);
  | Tail, IfEq(range', x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_tail_if range oc lines e1 e2 "beq" "bne"
  | Tail, IfEq(range', x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d%s\n" (reg x) y (comment_range lines range');
      g'_tail_if range oc lines e1 e2 "beq" "bne"
  | Tail, IfLE(range', x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_tail_if range oc lines e1 e2 "ble" "bgt"
  | Tail, IfLE(range', x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d%s\n" (reg x) y (comment_range lines range');
      g'_tail_if range oc lines e1 e2 "ble" "bgt"
  | Tail, IfGE(range', x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_tail_if range oc lines e1 e2 "bge" "blt"
  | Tail, IfGE(range', x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d%s\n" (reg x) y (comment_range lines range');
      g'_tail_if range oc lines e1 e2 "bge" "blt"
  | Tail, IfFEq(range', x, y, e1, e2) ->
      Printf.fprintf oc "\tfcmpu\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_tail_if range oc lines e1 e2 "beq" "bne"
  | Tail, IfFLE(range', x, y, e1, e2) ->
      Printf.fprintf oc "\tfcmpu\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_tail_if range oc lines e1 e2 "ble" "bgt"
  | NonTail(z), IfEq(range', x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_non_tail_if range oc lines (NonTail(z)) e1 e2 "beq" "bne"
  | NonTail(z), IfEq(range', x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d%s\n" (reg x) y (comment_range lines range');
      g'_non_tail_if range oc lines (NonTail(z)) e1 e2 "beq" "bne"
  | NonTail(z), IfLE(range', x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_non_tail_if range oc lines (NonTail(z)) e1 e2 "ble" "bgt"
  | NonTail(z), IfLE(range', x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d%s\n" (reg x) y (comment_range lines range');
      g'_non_tail_if range oc lines (NonTail(z)) e1 e2 "ble" "bgt"
  | NonTail(z), IfGE(range', x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_non_tail_if range oc lines (NonTail(z)) e1 e2 "bge" "blt"
  | NonTail(z), IfGE(range', x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d%s\n" (reg x) y (comment_range lines range');
      g'_non_tail_if range oc lines (NonTail(z)) e1 e2 "bge" "blt"
  | NonTail(z), IfFEq(range', x, y, e1, e2) ->
      Printf.fprintf oc "\tfcmpu\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_non_tail_if range oc lines (NonTail(z)) e1 e2 "beq" "bne"
  | NonTail(z), IfFLE(range', x, y, e1, e2) ->
      Printf.fprintf oc "\tfcmpu\tcr7, %s, %s%s\n" (reg x) (reg y) (comment_range lines range');
      g'_non_tail_if range oc lines (NonTail(z)) e1 e2 "ble" "bgt"
  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
  | Tail, CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      g'_args range oc lines [(x, reg_cl)] ys zs;
      Printf.fprintf oc "\tlwz\t%s, 0(%s)%s\n" (reg reg_sw) (reg reg_cl) (comment_range lines range);
      Printf.fprintf oc "\tmtctr\t%s\n\tbctr%s\n" (reg reg_sw) (comment_range lines range);
  | Tail, CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      g'_args range oc lines [] ys zs;
      Printf.fprintf oc "\tb\t%s%s\n" x (comment_range lines range)
  | NonTail(a), CallCls(x, ys, zs) ->
      Printf.fprintf oc "\tmflr\t%s%s\n" (reg reg_tmp) (comment_range lines range);
      g'_args range oc lines [(x, reg_cl)] ys zs;
      let ss = stacksize () in
      Printf.fprintf oc "\tstw\t%s, %d(%s)%s\n" (reg reg_tmp) (ss - 4) (reg reg_sp) (comment_range lines range);
      Printf.fprintf oc "\taddi\t%s, %s, %d%s\n" (reg reg_sp) (reg reg_sp) ss (comment_range lines range);
      Printf.fprintf oc "\tlwz\t%s, 0(%s)%s\n" (reg reg_tmp) (reg reg_cl) (comment_range lines range);
      Printf.fprintf oc "\tmtctr\t%s%s\n" (reg reg_tmp) (comment_range lines range);
      Printf.fprintf oc "\tbctrl%s\n" (comment_range lines range);
      Printf.fprintf oc "\tsubi\t%s, %s, %d%s\n" (reg reg_sp) (reg reg_sp) ss (comment_range lines range);
      Printf.fprintf oc "\tlwz\t%s, %d(%s)%s\n" (reg reg_tmp) (ss - 4) (reg reg_sp) (comment_range lines range);
      if List.mem a allregs && a <> regs.(0) then
        Printf.fprintf oc "\tmr\t%s, %s%s\n" (reg a) (reg regs.(0)) (comment_range lines range)
      else if List.mem a allfregs && a <> fregs.(0) then
        Printf.fprintf oc "\tfmr\t%s, %s%s\n" (reg a) (reg fregs.(0)) (comment_range lines range);
      Printf.fprintf oc "\tmtlr\t%s%s\n" (reg reg_tmp) (comment_range lines range)
  | (NonTail(a), CallDir(Id.L(x), ys, zs)) ->
      Printf.fprintf oc "\tmflr\t%s%s\n" (reg reg_tmp) (comment_range lines range);
      g'_args range oc lines [] ys zs;
      let ss = stacksize () in
      Printf.fprintf oc "\tstw\t%s, %d(%s)%s\n" (reg reg_tmp) (ss - 4) (reg reg_sp) (comment_range lines range);
      Printf.fprintf oc "\taddi\t%s, %s, %d%s\n" (reg reg_sp) (reg reg_sp) ss (comment_range lines range);
      Printf.fprintf oc "\tbl\t%s%s\n" x (comment_range lines range);
      Printf.fprintf oc "\tsubi\t%s, %s, %d%s\n" (reg reg_sp) (reg reg_sp) ss (comment_range lines range);
      Printf.fprintf oc "\tlwz\t%s, %d(%s)%s\n" (reg reg_tmp) (ss - 4) (reg reg_sp) (comment_range lines range);
      if List.mem a allregs && a <> regs.(0) then
        Printf.fprintf oc "\tmr\t%s, %s%s\n" (reg a) (reg regs.(0)) (comment_range lines range)
      else if List.mem a allfregs && a <> fregs.(0) then
        Printf.fprintf oc "\tfmr\t%s, %s%s\n" (reg a) (reg fregs.(0)) (comment_range lines range);
      Printf.fprintf oc "\tmtlr\t%s%s\n" (reg reg_tmp) (comment_range lines range)
(* MATSUSHITA: added range comments *)
and g'_tail_if range oc lines ((range1, _) as e1) ((range2, _) as e2) b bn =
  let b_else = Id.genid bn in
  Printf.fprintf oc "\t%s\tcr7, %s%s\n" bn b_else (comment_range lines range);
  Printf.fprintf oc "# %s:%s\n" b (comment_range' lines range1);
  let stackset_back = !stackset in
  g oc lines (Tail, e1);
  Printf.fprintf oc "%s:%s\n" b_else (comment_range lines range2);
  stackset := stackset_back;
  g oc lines (Tail, e2)
(* MATSUSHITA: added range comments *)
and g'_non_tail_if range oc lines dest ((range1, _) as e1) ((range2, _) as e2) b bn =
  let b_else = Id.genid bn in
  let b_cont = Id.genid "cont" in
  Printf.fprintf oc "\t%s\tcr7, %s%s\n" bn b_else (comment_range lines range);
  Printf.fprintf oc "# %s:%s\n" b (comment_range' lines range1);
  let stackset_back = !stackset in
  g oc lines (dest, e1);
  let stackset1 = !stackset in
  Printf.fprintf oc "\tb\t%s\n" b_cont;
  Printf.fprintf oc "%s:%s\n" b_else (comment_range lines range2);
  stackset := stackset_back;
  g oc lines (dest, e2);
  Printf.fprintf oc "%s:\n" b_cont;
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2
(* MATSUSHITA: added range comments *)
and g'_args range oc lines x_reg_cl ys zs =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
  List.iter
    (fun (y, r) -> Printf.fprintf oc "\tmr\t%s, %s%s\n" (reg r) (reg y) (comment_range lines range))
    (shuffle reg_sw yrs);
  let (d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  List.iter
    (fun (z, fr) -> Printf.fprintf oc "\tfmr\t%s, %s%s\n" (reg fr) (reg z) (comment_range lines range))
    (shuffle reg_fsw zfrs)

(* MATSUSHITA: added range comments *)
let h oc lines { range = range; name = Id.L(x); args = _; fargs = _; body = e; ret = _ } =
  Printf.fprintf oc "%s:%s\n" x (comment_range lines range);
  stackset := S.empty;
  stackmap := [];
  g oc lines (Tail, e)

let f oc lines (Prog(data, fundefs, e)) =
  Printf.printf "Generating assembly...\n";
  if data <> [] then
    (Printf.fprintf oc "\t.data\n\t.literal8\n";
     List.iter
       (fun (Id.L(x), d) ->
         Printf.fprintf oc "\t.align 3\n";
         Printf.fprintf oc "%s:\t# %f\n" x d;
         Printf.fprintf oc "\t.long\t%ld\n" (gethi d);
         Printf.fprintf oc "\t.long\t%ld\n" (getlo d))
       data);
  Printf.fprintf oc "\t.text\n";
  Printf.fprintf oc "\t.globl _min_caml_start\n";
  Printf.fprintf oc "\t.align 2\n";
  List.iter (fun fundef -> h oc lines fundef) fundefs;
  Printf.fprintf oc "_min_caml_start:\t# main entry point\n";
  Printf.fprintf oc "\tmflr\tr0\n";
  Printf.fprintf oc "\tstmw\tr30, -8(r1)\n";
  Printf.fprintf oc "\tstw\tr0, 8(r1)\n";
  Printf.fprintf oc "\tstwu\tr1, -96(r1)\n";
  Printf.fprintf oc "#\tmain program starts\n";
  stackset := S.empty;
  stackmap := [];
  g oc lines (NonTail("_R_0"), e);
  Printf.fprintf oc "#\tmain program ends\n";
  Printf.fprintf oc "\tlwz\tr1, 0(r1)\n";
  Printf.fprintf oc "\tlwz\tr0, 8(r1)\n";
  Printf.fprintf oc "\tmtlr\tr0\n";
  Printf.fprintf oc "\tlmw\tr30, -8(r1)\n";
  Printf.fprintf oc "\tblr\n"
