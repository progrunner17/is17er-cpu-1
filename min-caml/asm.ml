(* PowerPC assembly with a few virtual instructions *)

(* MATSUSHITA: added to t and exp H.range *)
type t = H.range * body
and body =
  | Ans of exp
  | Let of H.range * (Id.t * Type.t) * exp * t (* MATSUSHITA: added H.range *)
and exp = H.range * ebody
and ebody =
  | Nop
  | LI of int
  | FLI of float
  | LIL of Id.l
  | Mv of Id.t
  | Not of Id.t
  | Xor of Id.t * Id.t
  | Neg of Id.t
  | Add of Id.t * Id.t
  | AddI of Id.t * int
  | Sub of Id.t * Id.t
  | SllI of Id.t * int
  | SraI of Id.t * int
  | AndI of Id.t * int
  | LW of Id.t * int
  | LWA of Id.t * Id.t
  | SW of Id.t * Id.t * int
  | SWA of Id.t * Id.t * Id.t
  | FMv of Id.t
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
  | FLW of Id.t * int
  | FLWA of Id.t * Id.t
  | FSW of Id.t * Id.t * int
  | FSWA of Id.t * Id.t * Id.t
  | Read
  | Write of Id.t
  | FRead
  | FWrite of Id.t
  (* virtual instructions *)
  | IfEq of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  | IfLT of H.range * Id.t * Id.t * t * t (* MATSUSHITA: added H.range *)
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 *)
  | FSave of Id.t * Id.t
  | Restore of Id.t (* スタック変数から値を復元 *)
  | FRestore of Id.t
type fundef = { (* MATSUSHITA: added H.range *) range : H.range; name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }
type prog = Prog of fundef list * t

(* MATSUSHITA: added functions show_args, show, show_i, show_ebody and show_prog *)

let show_args prefix xs = if xs = [] then "" else " "^prefix^"("^String.concat ", " xs^")"

let rec show lines (range, body) = match body with
  | Ans (range', ebody) -> show_ebody lines range' ebody
  | Let (range', (x, t), (range'', ebody), e) ->
    let s1 = "let "^x^":"^Type.show t^H.comment_from_range lines range'^" = "^show_ebody lines range'' ebody in
    let s2 = s1^" in"^H.down () in
    s2^show lines e
and show_ebody lines range = function
  | Nop -> "nop"^H.comment_from_range lines range
  | LI n -> "li "^string_of_int n^H.comment_from_range lines range
  | FLI a -> "fli "^string_of_float a^H.comment_from_range lines range
  | LIL (Id.L x) -> "setl "^x^H.comment_from_range lines range
  | Mv x -> "mv "^x^H.comment_from_range lines range
  | Not x -> "not "^x^H.comment_from_range lines range
  | Xor (x, y) -> "xor "^x^" "^y^H.comment_from_range lines range
  | Neg x -> "neg "^x^H.comment_from_range lines range
  | Add (x, y) -> "add "^x^" "^y^H.comment_from_range lines range
  | AddI (x, n) -> "addi "^x^" "^string_of_int n^H.comment_from_range lines range
  | Sub (x, y) -> "sub "^x^" "^y^H.comment_from_range lines range
  | SllI (x, n) -> "slli "^x^" "^string_of_int n^H.comment_from_range lines range
  | SraI (x, n) -> "srai "^x^" "^string_of_int n^H.comment_from_range lines range
  | AndI (x, n) -> "andi "^x^" "^string_of_int n^H.comment_from_range lines range
  | LW (x, n) -> "lw "^string_of_int n^"("^x^")"^H.comment_from_range lines range
  | LWA (x, y) -> "lwa ("^x^", "^y^")"^H.comment_from_range lines range
  | SW (x, y, n) -> "sw "^x^" "^string_of_int n^"("^y^")"^H.comment_from_range lines range
  | SWA (x, y, z) -> "swa "^x^" ("^y^", "^z^")"^H.comment_from_range lines range
  | FMv x -> "fmv "^x^H.comment_from_range lines range
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
  | FAdd (x, y) -> "fadd "^x^" "^y^H.comment_from_range lines range
  | FSub (x, y) -> "fsub "^x^" "^y^H.comment_from_range lines range
  | FMul (x, y) -> "fmul "^x^" "^y^H.comment_from_range lines range
  | FDiv (x, y) -> "fdiv "^x^" "^y^H.comment_from_range lines range
  | FEq (x, y) -> "feq "^x^" "^y^H.comment_from_range lines range
  | FLT (x, y) -> "flt "^x^" "^y^H.comment_from_range lines range
  | FLW (x, n) -> "flw "^string_of_int n^"("^x^")"^H.comment_from_range lines range
  | FLWA (x, y) -> "flwa ("^x^", "^y^")"^H.comment_from_range lines range
  | FSW (x, y, n) -> "fsw "^x^" "^string_of_int n^"("^y^")"^H.comment_from_range lines range
  | FSWA (x, y, z) -> "fswa "^x^" ("^y^", "^z^")"^H.comment_from_range lines range
  | Read -> "read"^H.comment_from_range lines range
  | FRead -> "fread"^H.comment_from_range lines range
  | Write x -> "write "^x^H.comment_from_range lines range
  | FWrite x -> "fwrite "^x^H.comment_from_range lines range
  | IfEq (range', x, y, e, e') ->
    let s1 = "if eq "^x^" "^y^H.comment_from_range lines range'
      ^" then"^H.comment_from_range lines (fst e)^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else"^H.comment_from_range lines (fst e')^H.down_right () in
    let s5 = s4^show lines e' in
    s5^H.left ()
  | IfLT (range', x, y, e, e') ->
    let s1 = "if lt "^x^" "^y^H.comment_from_range lines range'
      ^" then"^H.comment_from_range lines (fst e)^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down_left () in
    let s4 = s3^"else"^H.comment_from_range lines (fst e')^H.down_right () in
    let s5 = s4^show lines e' in
    s5^H.left ()
  | CallCls (f, xs, ys) -> "call "^f^show_args "int" xs^show_args "float" ys^H.comment_from_range lines range
  | CallDir (Id.L f, xs, ys) -> "call *"^f^"*"^show_args "int" xs^show_args "float" ys^H.comment_from_range lines range
  | Save (x, y) -> "save "^x^" "^y^H.comment_from_range lines range
  | FSave (x, y) -> "fsave "^x^" "^y^H.comment_from_range lines range
  | Restore x -> "restore "^x^H.comment_from_range lines range
  | FRestore x -> "frestore "^x^H.comment_from_range lines range

let show_prog lines (Prog (fundefs, e)) =
  H.sep "" (fun { range = range; name = Id.L f; args = xs; fargs = ys; body = e; ret = t} ->
    let s1 = "let_fun *"^f^"*"^show_args "int" xs^show_args "float" ys
      ^" ="^H.comment_from_range lines range^H.down_right () in
    let s2 = s1^show lines e in
    let s3 = s2^H.down ()^":"^Type.show t in
    s3^" in"^H.down_left ()) fundefs^
  show lines e

(* MATSUSHITA: added to arguments two H.range's *)
let fletd(range, range', x, e1, e2) = range, Let(range', (x, Type.Float), e1, e2)
(* MATSUSHITA: added to arguments H.range *)
let seq(range, e1, e2) = range, Let(None, (Id.genunit (), Type.Unit), e1, e2)

let regs =
  [| "%x4"; "%x5"; "%x6"; "%x7"; "%x8"; "%x9"; "%x10";
     "%x11"; "%x12"; "%x13"; "%x14"; "%x15"; "%x16"; "%x17"; "%x18"; "%x19"; "%x20";
     "%x21"; "%x22"; "%x23"; "%x24"; "%x25"; "%x26"; "%x27"; "%x28"; "%x29" |]
let reg_const n = match n with
  | 0 -> "%x0"
  | _ -> raise Not_found
(* %x1 はリンクレジスタ、%x2 はスタックポインタ、%x3 はヒープのポインタに使う *)
(* %x4 は返り値のレジスタ *)
(* %x31 は一時変数用に多用途で使い、%x30 はシャッフルの一時変数に使い、%x29 はクロージャの保存場所に使う *)

let fregs =
  [| "%f1"; "%f2"; "%f3"; "%f4"; "%f5"; "%f6"; "%f7"; "%f8"; "%f9"; "%f10";
     "%f30" |]
module FM = Map.Make(struct
    type t = float
    let compare = compare
  end)
let const_fregs = List.fold_right (fun (a, x) -> FM.add a x) [
  0., "%f0";
  1., "%f11";
  2., "%f12";
  4., "%f13";
  10., "%f14";
  15., "%f15";
  20., "%f16";
  128., "%f17";
  200., "%f18";
  255., "%f19";
  850., "%f20";
  0.1, "%f21";
  0.2, "%f22";
  0.001, "%f23";
  0.005, "%f24";
  0.15, "%f25";
  0.25, "%f26";
  0.5, "%f27";
  3.1415927, "%f28";
  30.0 /. 3.1415927, "%f29"] FM.empty
let freg_const a = FM.find a const_fregs
(* %f1 は返り値のレジスタ *)
(* %f31 はシャッフルの一時変数に使う *)

let is_reg x = (x.[0] = '%')

let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

(* free variables in the order of use (for spilling) (caml2html: sparcasm_fv) *)
let rec fv_exp (range, ebody) = match ebody with
  | Nop | LI(_) | FLI(_) | LIL(_) | Restore(_) | FRestore(_) | Read | FRead -> []
  | LW(x, _) | FLW(x, _) | Mv(x) | Not(x) | Neg(x) | AddI(x, _) | SllI(x, _) | SraI(x, _) | AndI(x, _)
  | FMv(x) | FNeg(x) | FAbs(x) | FFloor(x) | IToF(x) | FToI(x)
  | FSqrt(x) | FCos(x) | FSin(x) | FTan(x) | FAtan(x) | Write(x) | FWrite(x) | Save(x, _) | FSave(x, _) -> [x]
  | Xor(x, y) | Add(x, y) | Sub(x, y) | LWA(x, y) | SW(x, y, _) | FLWA(x, y) | FSW(x, y, _) -> [x; y]
  | SWA(x, y, z) | FSWA(x, y, z) -> [x; y; z]
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | FEq(x, y) | FLT(x, y) -> [x; y]
  | IfEq(_, x, y, e1, e2) | IfLT(_, x, y, e1, e2) ->  x :: y :: remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | CallCls(x, ys, zs) -> x :: ys @ zs
  | CallDir(_, ys, zs) -> ys @ zs
and fv (range, ebody) = match ebody with
  | Ans(exp) -> fv_exp exp
  | Let(_, (x, _), exp, e) ->
      fv_exp exp @ remove_and_uniq (S.singleton x) (fv e)
let fv e = remove_and_uniq S.empty (fv e)

(* MATSUSHITA: added to arguments two H.range's *)
let rec concat range range' (_, body) xt e2 =
  match body with
  | Ans(exp) -> range, Let(range', xt, exp, e2)
  | Let(range'', yt, exp, e1') -> range, Let(range'', yt, exp, concat range range' e1' xt e2)
