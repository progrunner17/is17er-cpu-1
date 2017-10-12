(* MATSUSHITA: added <| oprator *)
let (<|) print x = print x; x

let limit = ref 1000

let rec iter n e = (* ��Ŭ�������򤯤꤫���� (caml2html: main_iter) *)
  if n = 0 then e else
  let e' = Elim.f (ConstFold.f (Inline.f (Assoc.f (Beta.f e)))) in
  if e = e' then e else
  (* MATSUSHITA: print intermediate result *)
  let _ = Printf.printf "[Iteration %d]\n%s\n\n" n (KNormal.show e') in
  iter (n - 1) e'

(* MATSUSHITA: print intermediate results *)
let lexbuf outchan l = (* �Хåե��򥳥�ѥ��뤷�ƥ����ͥ�ؽ��Ϥ��� (caml2html: main_lexbuf) *)
  Id.counter := 0;
  Typing.extenv := M.empty;
  Emit.f outchan
    ((fun prog -> Printf.printf "[RegAlloc.f]\n%s\n\n" (Asm.show_prog prog)) <| RegAlloc.f
       ((fun prog -> Printf.printf "[Simm.f]\n%s\n\n" (Asm.show_prog prog)) <| Simm.f
          ((fun prog -> Printf.printf "[Virtual.f]\n%s\n\n" (Asm.show_prog prog)) <| Virtual.f
             ((fun prog -> Printf.printf "[Closure.f]\n%s\n\n" (Closure.show_prog prog)) <| Closure.f
                (iter !limit
                   ((fun e -> Printf.printf "[Alpha.f]\n%s\n\n" (KNormal.show e)) <| Alpha.f
                      ((fun e -> Printf.printf "[KNormal.f]\n%s\n\n" (KNormal.show e)) <| KNormal.f
                         ((fun e -> Printf.printf "[Typing.f]\n%s\n\n" (Syntax.show e)) <| Typing.f
                            (Parser.exp Lexer.token l)))))))))

let string s = lexbuf stdout (Lexing.from_string s) (* ʸ����򥳥�ѥ��뤷��ɸ����Ϥ�ɽ������ (caml2html: main_string) *)

let file f = (* �ե�����򥳥�ѥ��뤷�ƥե�����˽��Ϥ��� (caml2html: main_file) *)
  let inchan = open_in (f ^ ".ml") in
  let outchan = open_out (f ^ ".s") in
  let buf = Lexing.from_channel inchan in
  try
    lexbuf outchan buf;
    close_in inchan;
    close_out outchan;
  with e -> close_in inchan; close_out outchan; raise e

let () = (* �������饳��ѥ���μ¹Ԥ����Ϥ���� (caml2html: main_entry) *)
  let files = ref [] in
  Arg.parse
    [("-inline", Arg.Int(fun i -> Inline.threshold := i), "maximum size of functions inlined");
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated")]
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-iter n] ...filenames without \".ml\"..." Sys.argv.(0));
  List.iter
    (fun f -> ignore (file f))
    !files
