type token =
  | BOOL of (bool)
  | INT of (int)
  | FLOAT of (float)
  | NOT
  | XOR
  | FISZERO
  | FLESS
  | FISPOS
  | FISNEG
  | FNEG
  | FABS
  | FHALF
  | FSQR
  | FLOOR
  | FLOATOFINT
  | INTOFFLOAT
  | SQRT
  | COS
  | SIN
  | TAN
  | ATAN
  | READINT
  | READFLOAT
  | PRINTINT
  | PRINTFLOAT
  | PLUS
  | MINUS
  | AST
  | SLASH
  | PLUS_DOT
  | MINUS_DOT
  | AST_DOT
  | SLASH_DOT
  | EQUAL
  | LESS_GREATER
  | LESS_EQUAL
  | GREATER_EQUAL
  | LESS
  | GREATER
  | IF
  | THEN
  | ELSE
  | IDENT of (Id.t)
  | LET
  | IN
  | REC
  | COMMA
  | ARRAY_CREATE
  | DOT
  | LESS_MINUS
  | OPEN
  | SEMISEMI
  | SEMICOLON
  | LPAREN
  | RPAREN
  | EOF

val exp :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Syntax.t
val globals :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (Id.t * Syntax.t) list
