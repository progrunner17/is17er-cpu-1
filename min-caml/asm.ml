(* PowerPC assembly with a few virtual instructions *)

type id_or_imm = V of Id.t | C of int
(* MATSUSHITA: added to t and exp H.range *)
type t = H.range * body
and body =
  | Ans of exp
  | Let of H.range * (Id.t * Type.t) * exp * t (* MATSUSHITA: added H.range *)
and exp = H.range * ebody
and ebody =
  | Nop
  | Li of int
  | FLi of Id.l
  | SetL of Id.l
  | Mr of Id.t
  | Neg of Id.t
  | Add of Id.t * id_or_imm
  | Sub of Id.t * id_or_imm
  | Slw of Id.t * id_or_imm
  | Lwz of Id.t * id_or_imm
  | Stw of Id.t * Id.t * id_or_imm
  | FMr of Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | Lfd of Id.t * id_or_imm
  | Stfd of Id.t * Id.t * id_or_imm
  | Comment of string
  (* virtual instructions *)
  | IfEq of H.range * Id.t * id_or_imm * t * t (* MATSUSHITA: added H.range *)
  | IfLE of H.range * Id.t * id_or_imm * t * t (* MATSUSHITA: added H.range *)
  | IfGE of H.range * Id.t * id_or_imm * t * t (* MATSUSHITA: added H.range *)
  | IfFEq of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | IfFLE of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 *)
  | Restore of Id.t (* スタック変数から値を復元 *)
type fundef = { (* MATSUSHITA: added H.range *) range : H.range; name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }
type prog = Prog of (Id.l * float) list * fundef list * t

(* MATSUSHITA: added functions show_args, show, show_i, show_ebody and show_prog *)

let show_args prefix xs = if xs = [] then "" else " "^prefix^"("^String.concat ", " xs^")"

let rec show lines (range, body) = match body with
  | Ans (range', ebody) -> show_ebody lines range' ebody
  | Let (range', (x, t), (range'', ebody), e) ->
    let s1 = "let "^x^":"^Type.show t^H.show_from_range' lines range'^" = "^show_ebody lines range'' ebody in
    let s2 = s1^" in"^H.down () in
    s2^show lines e
and show_i = function
  | V x -> x
  | C n -> string_of_int n
and show_ebody lines range = function
  | Nop -> "nop"^H.show_from_range' lines range
  | Li n -> "li "^string_of_int n^H.show_from_range' lines range
  | FLi (Id.L x) -> "fli "^x^H.show_from_range' lines range
  | SetL (Id.L x) -> "setl "^x^H.show_from_range' lines range
  | Mr x -> "mr "^x^H.show_from_range' lines range
  | Neg x -> "neg "^x^H.show_from_range' lines range
  | Add (x, i) -> "add "^x^" "^show_i i^H.show_from_range' lines range
  | Sub (x, i) -> "sub "^x^" "^show_i i^H.show_from_range' lines range
  | Slw (x, i) -> "slw "^x^" "^show_i i^H.show_from_range' lines range
  | Lwz (x, i) -> "lwz "^x^"("^show_i i^")"^H.show_from_range' lines range
  | Stw (x, y, i) -> "stw "^x^" "^y^"("^show_i i^")"^H.show_from_range' lines range
  | FMr x -> "fmr "^x^H.show_from_range' lines range
  | FNeg x -> "fneg "^x^H.show_from_range' lines range
  | FAdd (x, y) -> "fadd "^x^" "^y^H.show_from_range' lines range
  | FSub (x, y) -> "fsub "^x^" "^y^H.show_from_range' lines range
  | FMul (x, y) -> "fmul "^x^" "^y^H.show_from_range' lines range
  | FDiv (x, y) -> "fdiv "^x^" "^y^H.show_from_range' lines range
  | Lfd (x, i) -> "lfd "^x^"("^show_i i^")"^H.show_from_range' lines range
  | Stfd (x, y, i) -> "stfd "^x^" "^y^"("^show_i i^")"^H.show_from_range' lines range
  | Comment s -> "(* "^s^" *)"^H.show_from_range' lines range
  | IfEq (range', x, i, e, e') ->
    let s1 = "if eq "^x^" "^show_i i^H.show_from_range' lines range'
      ^" then"^H.show_from_range' lines (fst e)^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else"^H.show_from_range' lines (fst e')^H.down_right () in
    let s5 = s4^show lines e' in
    s5^H.left ()
  | IfLE (range', x, i, e, e') ->
    let s1 = "if le "^x^" "^show_i i^H.show_from_range' lines range'
      ^" then"^H.show_from_range' lines (fst e)^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else"^H.show_from_range' lines (fst e')^H.down_right () in
    let s5 = s4^show lines e' in
    s5^H.left ()
  | IfGE (range', x, i, e, e') ->
    let s1 = "if ge "^x^" "^show_i i^H.show_from_range' lines range'
      ^" then"^H.show_from_range' lines (fst e)^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else"^H.show_from_range' lines (fst e')^H.down_right () in
    let s5 = s4^show lines e' in
    s5^H.left ()
  | IfFEq (range', x, y, e, e') ->
    let s1 = "if feq "^x^" "^y^H.show_from_range' lines range'
      ^" then"^H.show_from_range' lines (fst e)^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else"^H.show_from_range' lines (fst e')^H.down_right () in
    let s5 = s4^show lines e' in
    s5^H.left ()
  | IfFLE (range', x, y, e, e') ->
    let s1 = "if fle "^x^" "^y^H.show_from_range' lines range'
      ^" then"^H.show_from_range' lines (fst e)^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else"^H.show_from_range' lines (fst e')^H.down_right () in
    let s5 = s4^show lines e' in
    s5^H.left ()
  | CallCls (f, xs, ys) -> "call "^f^show_args "int" xs^show_args "float" ys^H.show_from_range' lines range
  | CallDir (Id.L f, xs, ys) -> "call *"^f^"*"^show_args "int" xs^show_args "float" ys^H.show_from_range' lines range
  | Save (x, y) -> "save "^x^" "^y^H.show_from_range' lines range
  | Restore x -> "restore "^x^H.show_from_range' lines range

let show_prog lines (Prog (table, fundefs, e)) =
  H.sep "" (fun (Id.L x, a) -> "let_float "^x^" = "^string_of_float a^" in\n") table^
  H.sep "" (fun { range = range; name = Id.L f; args = xs; fargs = ys; body = e; ret = t} ->
    let s1 = "let_fun *"^f^"*"^show_args "int" xs^show_args "float" ys
      ^" ="^H.show_from_range' lines range^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down ()^":"^Type.show t in
    s3^" in"^H.down_left ()) fundefs^
  show lines e

(* MATSUSHITA: added to arguments two H.range's *)
let fletd(range, range', x, e1, e2) = range, Let(range', (x, Type.Float), e1, e2)
(* MATSUSHITA: added to arguments H.range *)
let seq(range, e1, e2) = range, Let(None, (Id.genunit (), Type.Unit), e1, e2)

let regs = (* Array.init 27 (fun i -> Printf.sprintf "_R_%d" i) *)
  [| "%r2"; "%r5"; "%r6"; "%r7"; "%r8"; "%r9"; "%r10";
     "%r11"; "%r12"; "%r13"; "%r14"; "%r15"; "%r16"; "%r17"; "%r18";
     "%r19"; "%r20"; "%r21"; "%r22"; "%r23"; "%r24"; "%r25"; "%r26";
     "%r27"; "%r28"; "%r29"; "%r30" |]
let fregs = Array.init 32 (fun i -> Printf.sprintf "%%f%d" i)
let allregs = Array.to_list regs
let allfregs = Array.to_list fregs
let reg_cl = regs.(Array.length regs - 1) (* closure address (caml2html: sparcasm_regcl) *)
let reg_sw = regs.(Array.length regs - 2) (* temporary for swap *)
let reg_fsw = fregs.(Array.length fregs - 1) (* temporary for swap *)
let reg_sp = "%r3" (* stack pointer *)
let reg_hp = "%r4" (* heap pointer (caml2html: sparcasm_reghp) *)
let reg_tmp = "%r31" (* [XX] ad hoc *)
let is_reg x = (x.[0] = '%')

(* super-tenuki *)
let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

(* free variables in the order of use (for spilling) (caml2html: sparcasm_fv) *)
let fv_id_or_imm = function V(x) -> [x] | _ -> []
let rec fv_exp (_, body) = match body with
  | Nop | Li(_) | FLi(_) | SetL(_) | Comment(_) | Restore(_) -> []
  | Mr(x) | Neg(x) | FMr(x) | FNeg(x) | Save(x, _) -> [x]
  | Add(x, y') | Sub(x, y') | Slw(x, y') | Lfd(x, y') | Lwz(x, y') -> x :: fv_id_or_imm y'
  | Stw(x, y, z') | Stfd(x, y, z') -> x :: y :: fv_id_or_imm z'
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> [x; y]
  | IfEq(_, x, y', e1, e2) | IfLE(_, x, y', e1, e2) | IfGE(_, x, y', e1, e2) ->  x :: fv_id_or_imm y' @ remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | IfFEq(_, x, y, e1, e2) | IfFLE(_, x, y, e1, e2) -> x :: y :: remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | CallCls(x, ys, zs) -> x :: ys @ zs
  | CallDir(_, ys, zs) -> ys @ zs
and fv (_, body) = match body with
  | Ans(exp) -> fv_exp exp
  | Let(_, (x, t), exp, e) ->
      fv_exp exp @ remove_and_uniq (S.singleton x) (fv e)
let fv e = remove_and_uniq S.empty (fv e)

(* MATSUSHITA: added to arguments two H.range's *)
let rec concat range range' (_, body) xt e2 =
  match body with
  | Ans(exp) -> range, Let(range', xt, exp, e2)
  | Let(range'', yt, exp, e1') -> range, Let(range'', yt, exp, concat range range' e1' xt e2)

let align i = (if i mod 8 = 0 then i else i + 4)
