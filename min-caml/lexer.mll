{
(* lexerが利用する変数、関数、型などの定義 *)
open Parser
open Type
}

(* 正規表現の略記 *)
(* MATSUSHITA: added newline *)
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
    { comment lexbuf; (* ネストしたコメントのためのトリック *)
      token lexbuf }
| '('
    { LPAREN }
| ')'
    { RPAREN }
| "true"
    { BOOL(true) }
| "false"
    { BOOL(false) }
| "not"
    { NOT }
| "xor"
    { XOR }
| "fiszero"
    { FISZERO }
| "fless"
    { FLESS }
| "fispos"
    { FISPOS }
| "fisneg"
    { FISNEG }
| "fneg"
    { FNEG }
| "fabs"
    { FABS }
| "fhalf"
    { FHALF }
| "fsqr"
    { FSQR }
| "floor"
    { FLOOR }
| "float_of_int"
    { FLOATOFINT }
| "int_of_float"
    { INTOFFLOAT }
| "sqrt"
    { SQRT }
| "cos"
    { COS }
| "sin"
    { SIN }
| "tan"
    { TAN }
| "atan"
    { ATAN }
| "read_int"
    { READINT }
| "read_float"
    { READFLOAT }
| "print_int"
    { PRINTINT }
| "print_float"
    { PRINTFLOAT }
| digit+ (* 整数を字句解析するルール (caml2html: lexer_int) *)
    { INT(int_of_string (Lexing.lexeme lexbuf)) }
| digit+ ('.' digit*)? (['e' 'E'] ['+' '-']? digit+)?
    { FLOAT(float_of_string (Lexing.lexeme lexbuf)) }
| '+'
    { PLUS }
| '-'
    { MINUS }
| '*'
    { AST }
| '/'
    { SLASH }
| "+."
    { PLUS_DOT }
| "-."
    { MINUS_DOT }
| "*."
    { AST_DOT }
| "/."
    { SLASH_DOT }
| '='
    { EQUAL }
| "<>"
    { LESS_GREATER }
| "<="
    { LESS_EQUAL }
| ">="
    { GREATER_EQUAL }
| '<'
    { LESS }
| '>'
    { GREATER }
| "if"
    { IF }
| "then"
    { THEN }
| "else"
    { ELSE }
| "let"
    { LET }
| "in"
    { IN }
| "rec"
    { REC }
| ','
    { COMMA }
| '_'
    { IDENT(Id.genunit ()) }
| "create_array" | "Array.create" | "Array.make"
    { ARRAY_CREATE }
| '.'
    { DOT }
| "<-"
    { LESS_MINUS }
| ';'
    { SEMICOLON }
(* MATSUSHITA: added "open", ";;", "fun" and "->" *)
| "open" { OPEN }
| ";;" { SEMISEMI }
| "fun" { FUN }
| "->" { MINUS_GREATER }
| eof
    { EOF }
| lower (digit|lower|upper|'_'|''')* (* 他の「予約語」より後でないといけない *)
    { IDENT(Lexing.lexeme lexbuf) }
| _
    { (* MATSUSHITA: modified error message *)
      Printf.printf "Lex error: Unknown token %s at %s\n" (Lexing.lexeme lexbuf) (H.show_range (Some (lexbuf.Lexing.lex_start_p, lexbuf.Lexing.lex_curr_p)));
      exit 1 }
and comment = parse
| "*)"
    { () }
| "(*"
    { comment lexbuf;
      comment lexbuf }
| eof
    { Printf.printf "Lex warning: Unterminated comment\n" }
| newline
    { Lexing.new_line lexbuf; comment lexbuf }
| _
    { comment lexbuf }
