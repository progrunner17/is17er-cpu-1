open Asm
open Lexing

(* MATSUSHITA: added functions upper_float and lower_float instead of get_hi and get_lo *)
external upper_float: float -> int32 = "upper_float"
external lower_float: float -> int32 = "lower_float"

(* MATSUSHITA: added functions upper and lower *)
let upper n = n asr 12 + if n land (1 lsl 11) = 0 then 0 else 1
let lower n = (n lsl 51) asr 51 (* 符号拡張を行っている。int が 63bit 整数であることに注意 *)
let upper' n = n asr 19 + if n land (1 lsl 18) = 0 then 0 else 1
let lower' n = (n lsl 44) asr 44 (* 符号拡張を行っている。int が 63bit 整数であることに注意 *)

(* MATSUSHITA: added pc and labels*)
let pc = ref 0
let labels = ref M.empty

(* MATSUSHITA: added functions comment_range and comment_range' *)
let comment_range lines range = match range with
  | None -> "\n"
  | _ -> "\t# "^H.show_from_range lines range^"\n"
let comment_range' lines range = match range with
  | None -> "\n"
  | _ -> "\t"^H.show_from_range lines range^"\n"

let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)
let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)
let save x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let offset x =
  let rec go = function
    | [] -> raise Not_found
    | y :: zs when x = y -> 0
    | y :: zs -> 1 + go zs in
  go !stackmap
let stacksize () = List.length !stackmap + 1 (* リンクレジスタ退避先が確保してある *)

(* MATSUSHITA: modified reg and added function freg *)
let reg r =
  assert(String.sub r 0 2 = "%x");
  String.sub r 1 (String.length r - 1)
let freg r =
  assert(String.sub r 0 2 = "%f");
  String.sub r 1 (String.length r - 1)

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
let rec g lines (dest, (_, body)) = match body with (* 命令列のアセンブリ生成 (caml2html: emit_g) *)
  | Ans(exp) -> g' lines (dest, exp)
  | Let(range', (x, t), exp, e) ->
      let s0 = if range' = None then "" else comment_range lines range' in
      let s1 = g' lines (NonTail(x), exp) in
      let s2 = g lines (dest, e) in
      s0^s1^s2
(* MATSUSHITA: added range comments *)
and g' lines (dest, ((range, body) as exp)) =
  match (dest, body) with (* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  | NonTail(_), Nop -> ""
  | NonTail(x), LI(n) ->
      let regx = reg x in
      if upper n = 0 then
        let _ = pc := !pc + 1 in
        Printf.sprintf "\taddi\t%s, x0, %d%s" regx n (comment_range lines range)
      else
        let _ = pc := !pc + 2 in
        Printf.sprintf "\tlui\t%s, %d%s" regx (upper n) (comment_range lines range)^
        Printf.sprintf "\taddi\t%s, %s, %d%s" regx regx (lower n) (comment_range lines range)
  | NonTail(x), FLI(a) ->
      let m = Int32.to_int @@ upper_float a in
      let n = Int32.to_int @@ lower_float a in
      if m = 0 then
        let _ = pc := !pc + 2 in
        Printf.sprintf "\taddi\tx31, x0, %d%s" n (comment_range lines range)^
        Printf.sprintf "\txtof\t%s, x31%s" (freg x) (comment_range lines range)
      else
        let _ = pc := !pc + 3 in
        Printf.sprintf "\tlui\tx31, %d%s" m (comment_range lines range)^
        Printf.sprintf "\taddi\tx31, x31, %d%s" n (comment_range lines range)^
        Printf.sprintf "\txtof\t%s, x31%s" (freg x) (comment_range lines range)
  | NonTail(x), LIL(Id.L(y)) ->
      let n = M.find y !labels in
      let regx = reg x in
      if upper n = 0 then
        let _ = pc := !pc + 1 in
        Printf.sprintf "\taddi\t%s, x0, %d%s" regx n (comment_range lines range)
      else
        let _ = pc := !pc + 2 in
        Printf.sprintf "\tlui\t%s, %d%s" regx (upper n) (comment_range lines range)^
        Printf.sprintf "\taddi\t%s, %s, %d%s" regx regx (lower n) (comment_range lines range)
  | NonTail(x), Mv(y) when x = y -> ""
  | NonTail(x), Mv(y) ->
      pc := !pc + 1;
      Printf.sprintf "\taddi\t%s, %s, 0%s" (reg x) (reg y) (comment_range lines range)
  | NonTail(x), Not(y) ->
      pc := !pc + 1;
      Printf.sprintf "\txori\t%s, %s, -1%s" (reg x) (reg y) (comment_range lines range)
  | NonTail(x), Xor(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\txor\t%s, %s, %s%s" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), Neg(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tsub\t%s, x0, %s%s" (reg x) (reg y) (comment_range lines range)
  | NonTail(x), Add(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\tadd\t%s, %s, %s%s" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), AddI(y, n) ->
      assert(-2048 <= n && n <= 2047);
      pc := !pc + 1;
      Printf.sprintf "\taddi\t%s, %s, %d%s" (reg x) (reg y) n (comment_range lines range)
  | NonTail(x), Sub(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\tsub\t%s, %s, %s%s" (reg x) (reg y) (reg z) (comment_range lines range)
  | NonTail(x), SllI(y, n) ->
      assert(-2048 <= n && n <= 2047);
      pc := !pc + 1;
      Printf.sprintf "\tslli\t%s, %s, %d%s" (reg x) (reg y) n (comment_range lines range)
  | NonTail(x), SraI(y, n) ->
      assert(-2048 <= n && n <= 2047);
      pc := !pc + 1;
      Printf.sprintf "\tsrai\t%s, %s, %d%s" (reg x) (reg y) n (comment_range lines range)
  | NonTail(x), AndI(y, n) ->
      assert(-2048 <= n && n <= 2047);
      pc := !pc + 1;
      Printf.sprintf "\tandi\t%s, %s, %d%s" (reg x) (reg y) n (comment_range lines range)
  | NonTail(x), LW(y, n) ->
      assert(-2048 <= n && n <= 2047);
      pc := !pc + 1;
      Printf.sprintf "\tlw\t%s, %d(%s)%s" (reg x) n (reg y) (comment_range lines range)
  | NonTail(x), LWA(y, z) ->
      pc := !pc + 2;
      Printf.sprintf "\tadd\tx31, %s, %s%s" (reg y) (reg z) (comment_range lines range)^
      Printf.sprintf "\tlw\t%s, 0(x31)%s" (reg x) (comment_range lines range)
  | NonTail(_), SW(x, y, n) ->
      assert(-2048 <= n && n <= 2047);
      pc := !pc + 1;
      Printf.sprintf "\tsw\t%s, %d(%s)%s" (reg x) n (reg y) (comment_range lines range)
  | NonTail(_), SWA(x, y, z) ->
      pc := !pc + 2;
      Printf.sprintf "\tadd\tx31, %s, %s%s" (reg y) (reg z) (comment_range lines range)^
      Printf.sprintf "\tsw\t%s, 0(x31)%s" (reg x) (comment_range lines range)
  | NonTail(x), FMv(y) when x = y -> ""
  | NonTail(x), FMv(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tfmv\t%s, %s%s" (freg x) (freg y) (comment_range lines range)
  | NonTail(x), FNeg(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tfneg\t%s, %s%s" (freg x) (freg y) (comment_range lines range)
  | NonTail(x), FAbs(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tfabs\t%s, %s%s" (freg x) (freg y) (comment_range lines range)
  | NonTail(x), FFloor(y) ->
      pc := !pc + 2;
      Printf.sprintf "\tftoi\tx31, %s%s" (freg y) (comment_range lines range)^
      Printf.sprintf "\titof\t%s, x31%s" (freg x) (comment_range lines range)
  | NonTail(x), FToI(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tftoi\t%s, %s%s" (reg x) (freg y) (comment_range lines range)
  | NonTail(x), IToF(y) ->
      pc := !pc + 1;
      Printf.sprintf "\titof\t%s, %s%s" (freg x) (reg y) (comment_range lines range)
  | NonTail(x), FSqrt(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tfsqrt\t%s, %s%s" (freg x) (freg y) (comment_range lines range)
  | NonTail(x), FCos(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tcos\t%s, %s%s" (freg x) (freg y) (comment_range lines range)
  | NonTail(x), FSin(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tsin\t%s, %s%s" (freg x) (freg y) (comment_range lines range)
  | NonTail(x), FTan(y) ->
      pc := !pc + 1;
      Printf.sprintf "\ttan\t%s, %s%s" (freg x) (freg y) (comment_range lines range)
  | NonTail(x), FAtan(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tatan\t%s, %s%s" (freg x) (freg y) (comment_range lines range)
  | NonTail(x), FAdd(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\tfadd\t%s, %s, %s%s" (freg x) (freg y) (freg z) (comment_range lines range)
  | NonTail(x), FSub(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\tfsub\t%s, %s, %s%s" (freg x) (freg y) (freg z) (comment_range lines range)
  | NonTail(x), FMul(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\tfmul\t%s, %s, %s%s" (freg x) (freg y) (freg z) (comment_range lines range)
  | NonTail(x), FDiv(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\tfdiv\t%s, %s, %s%s" (freg x) (freg y) (freg z) (comment_range lines range)
  | NonTail(x), FEq(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\tfeq\t%s, %s, %s%s" (reg x) (freg y) (freg z) (comment_range lines range)
  | NonTail(x), FLT(y, z) ->
      pc := !pc + 1;
      Printf.sprintf "\tflt\t%s, %s, %s%s" (reg x) (freg y) (freg z) (comment_range lines range)
  | NonTail(x), FLW(y, n) ->
      assert(-2048 <= n && n <= 2047);
      pc := !pc + 1;
      Printf.sprintf "\tflw\t%s, %d(%s)%s" (freg x) n (reg y) (comment_range lines range)
  | NonTail(x), FLWA(y, z) ->
      pc := !pc + 2;
      Printf.sprintf "\tadd\tx31, %s, %s%s" (reg y) (reg z) (comment_range lines range)^
      Printf.sprintf "\tflw\t%s, 0(x31)%s" (freg x) (comment_range lines range)
  | NonTail(_), FSW(x, y, n) ->
      assert(-2048 <= n && n <= 2047);
      pc := !pc + 1;
      Printf.sprintf "\tfsw\t%s, %d(%s)%s" (freg x) n (reg y) (comment_range lines range)
  | NonTail(_), FSWA(x, y, z) ->
      pc := !pc + 2;
      Printf.sprintf "\tadd\tx31, %s, %s%s" (reg y) (reg z) (comment_range lines range)^
      Printf.sprintf "\tfsw\t%s, 0(x31)%s" (freg x) (comment_range lines range)
  | NonTail(x), Read ->
      pc := !pc + 1;
      Printf.sprintf "\tlw\t%s, -64(x0)%s" (reg x) (comment_range lines range)
  | NonTail(x), FRead ->
      pc := !pc + 1;
      Printf.sprintf "\tflw\t%s, -64(x0)%s" (freg x) (comment_range lines range)
  | NonTail(_), Write(x) ->
      pc := !pc + 1;
      Printf.sprintf "\tsw\t%s, -63(x0)%s" (reg x) (comment_range lines range)
  | NonTail(_), FWrite(x) ->
      pc := !pc + 1;
      Printf.sprintf "\tfsw\t%s, -63(x0)%s" (freg x) (comment_range lines range)
  (* 退避の仮想命令の実装 (caml2html: emit_save) *)
  | NonTail(_), Save(x, y) when not (S.mem y !stackset) ->
      save y;
      pc := !pc + 1;
      Printf.sprintf "\tsw\t%s, %d(x2)%s" (reg x) (offset y) (comment_range lines range)
  | NonTail(_), FSave(x, y) when not (S.mem y !stackset) ->
      save y;
      pc := !pc + 1;
      Printf.sprintf "\tfsw\t%s, %d(x2)%s" (freg x) (offset y) (comment_range lines range)
  | NonTail(_), (Save(_, y) | FSave(_, y)) -> assert (S.mem y !stackset); ""
  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
  | NonTail(x), Restore(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tlw\t%s, %d(x2)%s" (reg x) (offset y) (comment_range lines range)
  | NonTail(x), FRestore(y) ->
      pc := !pc + 1;
      Printf.sprintf "\tflw\t%s, %d(x2)%s" (freg x) (offset y) (comment_range lines range)
  (* 末尾だったら計算結果を第一レジスタにセットしてリターン (caml2html: emit_tailret) *)
  | Tail, (Nop | SW _ | SWA _ | FSW _ | FSWA _ | Write _ | FWrite _ | Save _ | FSave _) ->
      let s = g' lines (NonTail(Id.genunit ()), exp) in
      pc := !pc + 1;
      s^Printf.sprintf "\tjalr x0, x1, 0%s" (comment_range lines range)
  | Tail, (LI _ | LIL _ | Mv _ | Not _ | Xor _
    | Neg _ | Add _ | AddI _ | Sub _ | SllI _ | SraI _ | AndI _ | LW _ | LWA _ | FToI _ | FEq _ | FLT _ | Read | Restore _) ->
      let s = g' lines (NonTail("%x4"), exp) in
      pc := !pc + 1;
      s^Printf.sprintf "\tjalr\tx0, x1, 0%s" (comment_range lines range)
  | Tail, (FLI _ | FMv _ | FNeg _ | FAbs _ | FFloor _ | IToF _ | FSqrt _
    | FCos _ | FSin _ | FTan _ | FAtan _
    | FAdd _ | FSub _ | FMul _ | FDiv _ | FLW _ | FLWA _ | FRead | FRestore _) ->
      let s = g' lines (NonTail("%f1"), exp) in
      pc := !pc + 1;
      s^Printf.sprintf "\tjalr\tx0, x1, 0%s" (comment_range lines range)
  | Tail, IfEq(_, x, y, e1, e2) ->
      g'_tail_if lines range x y "beq" e1 "bne" e2
  | Tail, IfLT(_, x, y, e1, e2) ->
      g'_tail_if lines range x y "blt" e1 "bge" e2
  | NonTail(z), IfEq(range', x, y, e1, e2) ->
      g'_non_tail_if lines (NonTail z) range x y "beq" e1 "bne" e2
  | NonTail(z), IfLT(range', x, y, e1, e2) ->
      g'_non_tail_if lines (NonTail z) range x y "blt" e1 "bge" e2
  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
  | Tail, CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      let s = g'_args range lines [(x, "%x29")] ys zs in
      pc := !pc + 2;
      s^
      Printf.sprintf "\tlw\tx31, 0(x29)%s" (comment_range lines range)^
      Printf.sprintf "\tjalr\tx0, x31, 0%s" (comment_range lines range)
  | Tail, CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      let s = g'_args range lines [] ys zs in
      pc := !pc + 1;
      let n = M.find x !labels - !pc in
      if upper' n = 0 then
        s^
        Printf.sprintf "\tjal\tx0, %d%s" n (comment_range lines range)
      else
        s^
        Printf.sprintf "\tauipc\tx31, %d%s" (upper' n) (comment_range lines range)^
        let _ = pc := !pc + 1 in
        Printf.sprintf "\tjalr\tx0, x31, %d%s" (lower' n) (comment_range lines range)
  | NonTail(a), CallCls(x, ys, zs) ->
      let ss = stacksize () in
      let s1 = g'_args range lines [(x, "%x29")] ys zs in
      s1^
      let _ = pc := !pc + 7 in
      Printf.sprintf "\tsw\tx1, %d(x2)%s" (ss - 1) (comment_range lines range)^
      Printf.sprintf "\taddi\tx2, x2, %d%s" ss (comment_range lines range)^
      Printf.sprintf "\tlw\tx31, 0(x29)%s" (comment_range lines range)^
      Printf.sprintf "\tjalr\tx1, x31, 0%s" (comment_range lines range)^
      Printf.sprintf "\taddi\tx2, x2, %d%s" (-ss) (comment_range lines range)^
      Printf.sprintf "\tlw\tx1, %d(x2)%s" (ss - 1) (comment_range lines range)^
      (match String.sub a 0 2 with
        | "%x" -> Printf.sprintf "\taddi\t%s, x4, 0%s" (reg a) (comment_range lines range)
        | "%f" -> Printf.sprintf "\tfmr\t%s, f1%s" (freg a) (comment_range lines range)
        | _ -> failwith @@ "invalid register"^a)
  | NonTail(a), CallDir(Id.L(x), ys, zs) ->
      let ss = stacksize () in
      let s1 = g'_args range lines [] ys zs in
      let _ = pc := !pc + 1 in
      let s2 = Printf.sprintf "\taddi\tx2, x2, %d%s" ss (comment_range lines range) in
      let s3 =
        let _ = pc := !pc + 1 in
        let n = M.find x !labels - !pc in
        if upper' n = 0 then
          Printf.sprintf "\tjal\tx1, %d%s" n (comment_range lines range)
        else
          Printf.sprintf "\tauipc\tx31, %d%s" (upper' n) (comment_range lines range)^
          let _ = pc := !pc + 1 in
          Printf.sprintf "\tjalr\tx1, x31, %d%s" (lower' n) (comment_range lines range) in
      let _ = pc := !pc + 3 in
      let s4 =
        Printf.sprintf "\taddi\tx2, x2, %d%s" (-ss) (comment_range lines range)^
        Printf.sprintf "\tlw\tx1, %d(x2)%s" (ss - 1) (comment_range lines range)^
        match String.sub a 0 2 with
          | "%x" -> Printf.sprintf "\taddi\t%s, x4, 0%s" (reg a) (comment_range lines range)
          | "%f" -> Printf.sprintf "\tfmr\t%s, f1%s" (freg a) (comment_range lines range)
          | _ -> failwith @@ "invalid register"^a in
      s1^s2^s3^s4
(* MATSUSHITA: added range comments *)
and g'_tail_if lines range x y b ((range1, _) as e1) bn ((range2, _) as e2) =
  let oldpc = !pc in
  pc := !pc + 1;
  let stackset_back = !stackset in
  let s1 = Printf.sprintf "# %s:%s" b (comment_range' lines range1)^
    g lines (Tail, e1) in
  let offset = !pc - oldpc in
  assert(0 <= offset && offset <= 2047);
  let s0 = Printf.sprintf "\t%s\t%s, %s, %d%s" bn (reg x) (reg y) offset (comment_range lines range) in
  stackset := stackset_back;
  let s2 = Printf.sprintf "# %s:%s" bn (comment_range' lines range2)^
    g lines (Tail, e2) in
  s0^s1^s2
(* MATSUSHITA: added range comments *)
and g'_non_tail_if lines dest range x y b ((range1, _) as e1) bn ((range2, _) as e2) =
  let oldpc1 = !pc in
  pc := !pc + 1;
  let stackset_back = !stackset in
  let s1 = Printf.sprintf "# %s:%s" b (comment_range' lines range1)^
    g lines (Tail, e1) in
  let oldpc2 = !pc in
  pc := !pc + 1;
  let offset1 = !pc - oldpc1 in
  assert(0 <= offset1 && offset1 <= 2047);
  let s0 = Printf.sprintf "\t%s\t%s, %s, %d%s" bn (reg x) (reg y) offset1 (comment_range lines range) in
  let stackset1 = !stackset in
  stackset := stackset_back;
  let s3 = Printf.sprintf "# %s:%s" bn (comment_range' lines range2)^
    g lines (Tail, e2)^
    Printf.sprintf "# cont:%s" (comment_range' lines range) in
  let offset2 = !pc - oldpc2 in
  assert(0 <= offset2 && offset2 <= 2047);
  let s2 = Printf.sprintf "\tjal\tx0, %d%s" offset2 (comment_range lines range) in
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2;
  s0^s1^s2^s3
(* MATSUSHITA: added range comments *)
and g'_args range lines x_reg_cl ys zs =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
  let s1 = List.fold_left
    (fun s (y, r) ->
       if r = y then "" else
       let _ = pc := !pc + 1 in
       s^Printf.sprintf "\taddi\t%s, %s, 0%s" (reg r) (reg y) (comment_range lines range))
    ""
    (shuffle "%x30" yrs) in
  let (d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  let s2 = List.fold_left
    (fun s (z, fr) ->
       if fr = z then "" else
       let _ = pc := !pc + 1 in
       s^Printf.sprintf "\tfmv\t%s, %s%s" (freg fr) (freg z) (comment_range lines range))
    ""
    (shuffle "%f31" zfrs) in
  s1^s2

(* MATSUSHITA: added range comments *)
let h lines { range = range; name = Id.L(x); args = _; fargs = _; body = e; ret = _ } =
  labels := M.add x !pc !labels;
  stackset := S.empty;
  stackmap := [];
  Printf.sprintf "# %s:%s" x (comment_range lines range)^
  g lines (Tail, e)

let f lines (Prog(fundefs, e)) =
  Printf.printf "Generating assembly...\n";
  pc := 2; (* 後のジャンプ命令のため *)
  labels := M.empty;
  let s2 = List.fold_left (fun s fundef -> s^h lines fundef) "" fundefs in
  let s1 =
    let n = !pc - 2 in
    "# jump to entry point\n"^
    Printf.sprintf "\tauipc\tx31, %d\n" (upper' n)^
    Printf.sprintf "\tjalr\tx0, x31, %d\n" (lower' n) in
  pc := !pc + 3;
  let s3 =
    "# entry point\n"^
    "\taddi x2, x0, 0\n"^
    Printf.sprintf "\tlui x3, %d\n" (upper 1048575)^
    Printf.sprintf "\taddi x3, x3, %d\n" (lower 1048575)^
    "# program begins\n" in
  stackset := S.empty;
  stackmap := [];
  let s4 =
    g lines (NonTail("%x4"), e)^
    "# program ends\n"^
    "\thlt\n" in
  s1^s2^s3^s4
