type token =
  | BOOL of (bool)
  | INT of (int)
  | FLOAT of (float)
  | NOT
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
  | UIDENT of (Id.t)
  | OPEN
  | SEMISEMI
  | DELIM
  | FUN
  | MINUS_GREATER
  | SEMICOLON
  | LPAREN
  | RPAREN
  | EOF
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
  | PRINTCHAR
  | PLUS_AT
  | MINUS_BANG

val prog :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Syntax.t
