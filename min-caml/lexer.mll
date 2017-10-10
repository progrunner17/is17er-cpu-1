{
(* lexer�����Ѥ����ѿ����ؿ������ʤɤ���� *)
open Parser
open Type
exception Error of string
}

(* ����ɽ����ά�� *)
let newline = ['\n']
let space = [' ' '\t' '\r']
let digit = ['0'-'9']
let lower = ['a'-'z']
let upper = ['A'-'Z']

rule token = parse
| newline
    { Lexing.new_line lexbuf; token lexbuf }
| space+
    { token lexbuf }
| "(*"
    { comment lexbuf; (* �ͥ��Ȥ��������ȤΤ���Υȥ�å� *)
      token lexbuf }
| '('
    { LPAREN(lexbuf.lex_curr_p) }
| ')'
    { RPAREN(lexbuf.lex_curr_p) }
| "true"
    { BOOL(lexbuf.lex_curr_p, true) }
| "false"
    { BOOL(lexbuf.lex_curr_p, false) }
| "not"
    { NOT(lexbuf.lex_curr_p) }
| digit+ (* �����������Ϥ���롼�� (caml2html: lexer_int) *)
    { INT(lexbuf.lex_curr_p, int_of_string (Lexing.lexeme lexbuf)) }
| digit+ ('.' digit*)? (['e' 'E'] ['+' '-']? digit+)?
    { FLOAT(lexbuf.lex_curr_p, float_of_string (Lexing.lexeme lexbuf)) }
| '-' (* -.����󤷤ˤ��ʤ��Ƥ��ɤ�? ��Ĺ����? *)
    { MINUS(lexbuf.lex_curr_p) }
| '+' (* +.����󤷤ˤ��ʤ��Ƥ��ɤ�? ��Ĺ����? *)
    { PLUS(lexbuf.lex_curr_p) }
| "-."
    { MINUS_DOT(lexbuf.lex_curr_p) }
| "+."
    { PLUS_DOT(lexbuf.lex_curr_p) }
| "*."
    { AST_DOT(lexbuf.lex_curr_p) }
| "/."
    { SLASH_DOT(lexbuf.lex_curr_p) }
| '='
    { EQUAL(lexbuf.lex_curr_p) }
| "<>"
    { LESS_GREATER(lexbuf.lex_curr_p) }
| "<="
    { LESS_EQUAL(lexbuf.lex_curr_p) }
| ">="
    { GREATER_EQUAL(lexbuf.lex_curr_p) }
| '<'
    { LESS(lexbuf.lex_curr_p) }
| '>'
    { GREATER(lexbuf.lex_curr_p) }
| "if"
    { IF(lexbuf.lex_curr_p) }
| "then"
    { THEN(lexbuf.lex_curr_p) }
| "else"
    { ELSE(lexbuf.lex_curr_p) }
| "let"
    { LET(lexbuf.lex_curr_p) }
| "in"
    { IN(lexbuf.lex_curr_p) }
| "rec"
    { REC(lexbuf.lex_curr_p) }
| ','
    { COMMA(lexbuf.lex_curr_p) }
| '_'
    { IDENT(lexbuf.lex_curr_p, Id.gentmp Type.Unit) }
| "Array.create" | "Array.make" (* [XX] ad hoc *)
    { ARRAY_CREATE(lexbuf.lex_curr_p) }
| '.'
    { DOT(lexbuf.lex_curr_p) }
| "<-"
    { LESS_MINUS(lexbuf.lex_curr_p) }
| ';'
    { SEMICOLON(lexbuf.lex_curr_p) }
| eof
    { EOF(lexbuf.lex_curr_p) }
| lower (digit|lower|upper|'_')* (* ¾�Ρ�ͽ���פ���Ǥʤ��Ȥ����ʤ� *)
    { IDENT(lexbuf.lex_curr_p, Lexing.lexeme lexbuf) }
| _
    { failwith (Printf.sprintf "Lex error: Unknown token %s (%s - %s)"
        (Lexing.lexeme lexbuf)
        (H.show_pos lexbuf.lex_start_p)
        (H.show_pos lexbuf.lex_curr_p)) }
and comment = parse
| "*)"
    { () }
| "(*"
    { comment lexbuf;
      comment lexbuf }
| eof
    { Format.eprintf "Lex warning: Unterminated comment@." }
| newline
    { Lexing.new_line lexbuf; comment lexbuf }
| _
    { comment lexbuf }
