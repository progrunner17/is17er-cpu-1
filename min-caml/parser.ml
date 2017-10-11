type token =
  | BOOL of (bool)
  | INT of (int)
  | FLOAT of (float)
  | NOT
  | MINUS
  | PLUS
  | MINUS_DOT
  | PLUS_DOT
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
  | SEMICOLON
  | LPAREN
  | RPAREN
  | EOF

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
(* parserが利用する変数、関数、型などの定義 *)
open Syntax
let addtyp x = (x, Type.gentyp ())
let symbol_range () = Some (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())
# 42 "parser.ml"
let yytransl_const = [|
  260 (* NOT *);
  261 (* MINUS *);
  262 (* PLUS *);
  263 (* MINUS_DOT *);
  264 (* PLUS_DOT *);
  265 (* AST_DOT *);
  266 (* SLASH_DOT *);
  267 (* EQUAL *);
  268 (* LESS_GREATER *);
  269 (* LESS_EQUAL *);
  270 (* GREATER_EQUAL *);
  271 (* LESS *);
  272 (* GREATER *);
  273 (* IF *);
  274 (* THEN *);
  275 (* ELSE *);
  277 (* LET *);
  278 (* IN *);
  279 (* REC *);
  280 (* COMMA *);
  281 (* ARRAY_CREATE *);
  282 (* DOT *);
  283 (* LESS_MINUS *);
  284 (* SEMICOLON *);
  285 (* LPAREN *);
  286 (* RPAREN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* BOOL *);
  258 (* INT *);
  259 (* FLOAT *);
  276 (* IDENT *);
    0|]

let yylhs = "\255\255\
\002\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\001\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\005\000\009\000\009\000\006\000\006\000\
\007\000\007\000\008\000\008\000\000\000"

let yylen = "\002\000\
\001\000\003\000\002\000\001\000\001\000\001\000\001\000\005\000\
\001\000\001\000\002\000\002\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\006\000\002\000\003\000\003\000\
\003\000\003\000\006\000\005\000\002\000\001\000\008\000\007\000\
\003\000\003\000\001\000\004\000\002\000\001\000\002\000\001\000\
\003\000\003\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\035\000\004\000\005\000\006\000\000\000\000\000\
\000\000\000\000\007\000\000\000\000\000\000\000\000\000\000\000\
\000\000\009\000\000\000\011\000\012\000\022\000\000\000\000\000\
\000\000\000\000\000\000\001\000\003\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\002\000\000\000\000\000\000\000\000\000\025\000\026\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\037\000\000\000\
\000\000\044\000\043\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\008\000\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\015\000\016\000\017\000\018\000\052\000\047\000\019\000\054\000\
\078\000"

let yysindex = "\006\000\
\106\255\000\000\000\000\000\000\000\000\000\000\106\255\106\255\
\106\255\106\255\000\000\241\254\117\255\075\255\086\002\001\255\
\000\000\000\000\245\254\000\000\000\000\000\000\220\255\004\255\
\255\254\000\255\096\255\000\000\000\000\142\255\106\255\106\255\
\106\255\106\255\106\255\106\255\106\255\106\255\106\255\106\255\
\106\255\106\255\106\255\106\255\249\254\253\254\117\255\106\255\
\106\255\106\255\005\255\002\255\023\255\232\254\003\255\253\254\
\000\000\008\255\008\255\008\255\008\255\000\000\000\000\058\255\
\058\255\058\255\058\255\058\255\058\255\130\002\086\002\106\255\
\253\254\130\002\014\002\038\002\005\255\015\255\106\255\009\255\
\028\255\017\255\106\255\168\255\106\255\106\255\000\000\106\255\
\086\002\000\000\000\000\106\255\194\255\022\255\110\002\086\002\
\086\002\062\002\000\000\106\255\106\255\110\002\086\002"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\053\000\000\000\
\001\000\000\000\169\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\061\000\117\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\143\000\
\000\000\195\000\221\000\247\000\018\001\000\000\000\000\048\001\
\078\001\108\001\134\001\160\001\186\001\193\001\254\000\000\000\
\091\000\212\001\000\000\000\000\043\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\035\001\000\000\000\000\000\000\000\000\031\000\230\001\065\001\
\034\255\000\000\000\000\000\000\000\000\244\001\095\001"

let yygindex = "\000\000\
\002\000\042\000\046\000\000\000\000\000\000\000\000\000\000\000\
\236\255"

let yytablesize = 914
let yytable = "\081\000\
\010\000\004\000\005\000\006\000\024\000\082\000\001\000\025\000\
\020\000\021\000\022\000\023\000\048\000\026\000\050\000\030\000\
\035\000\036\000\051\000\053\000\011\000\072\000\055\000\079\000\
\077\000\088\000\045\000\092\000\090\000\014\000\008\000\083\000\
\058\000\059\000\060\000\061\000\062\000\063\000\064\000\065\000\
\066\000\067\000\068\000\069\000\070\000\071\000\080\000\091\000\
\100\000\074\000\075\000\076\000\045\000\038\000\027\000\036\000\
\087\000\046\000\028\000\000\000\040\000\028\000\031\000\032\000\
\033\000\034\000\035\000\036\000\056\000\000\000\000\000\000\000\
\028\000\084\000\003\000\004\000\005\000\006\000\007\000\008\000\
\089\000\009\000\000\000\000\000\093\000\000\000\095\000\096\000\
\073\000\097\000\039\000\010\000\028\000\098\000\011\000\012\000\
\004\000\005\000\006\000\013\000\000\000\102\000\103\000\014\000\
\029\000\003\000\004\000\005\000\006\000\007\000\008\000\000\000\
\009\000\000\000\000\000\011\000\029\000\004\000\005\000\006\000\
\000\000\055\000\010\000\000\000\014\000\011\000\012\000\000\000\
\000\000\000\000\013\000\000\000\000\000\000\000\014\000\000\000\
\011\000\000\000\000\000\000\000\000\000\000\000\034\000\000\000\
\000\000\014\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\042\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\043\000\000\000\000\000\
\030\000\044\000\000\000\057\000\031\000\032\000\033\000\034\000\
\035\000\036\000\037\000\038\000\039\000\040\000\041\000\042\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\043\000\
\000\000\000\000\014\000\044\000\000\000\094\000\031\000\032\000\
\033\000\034\000\035\000\036\000\037\000\038\000\039\000\040\000\
\041\000\042\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\043\000\000\000\000\000\013\000\044\000\000\000\099\000\
\031\000\032\000\033\000\034\000\035\000\036\000\037\000\038\000\
\039\000\040\000\041\000\042\000\000\000\049\000\000\000\000\000\
\000\000\000\000\000\000\043\000\000\000\000\000\024\000\044\000\
\000\000\000\000\000\000\000\000\000\000\033\000\000\000\000\000\
\000\000\001\000\001\000\001\000\000\000\010\000\010\000\010\000\
\010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
\010\000\023\000\010\000\010\000\001\000\000\000\010\000\000\000\
\010\000\000\000\001\000\000\000\010\000\001\000\010\000\008\000\
\008\000\008\000\028\000\008\000\008\000\008\000\008\000\008\000\
\008\000\008\000\008\000\008\000\008\000\008\000\008\000\015\000\
\008\000\008\000\008\000\000\000\008\000\000\000\008\000\000\000\
\008\000\000\000\008\000\008\000\008\000\040\000\040\000\040\000\
\027\000\040\000\040\000\040\000\040\000\040\000\040\000\040\000\
\040\000\040\000\040\000\040\000\040\000\016\000\040\000\040\000\
\040\000\000\000\040\000\000\000\040\000\000\000\000\000\000\000\
\040\000\040\000\040\000\039\000\039\000\039\000\031\000\039\000\
\039\000\039\000\039\000\039\000\039\000\039\000\039\000\039\000\
\039\000\039\000\039\000\019\000\039\000\039\000\039\000\000\000\
\039\000\000\000\039\000\000\000\000\000\000\000\039\000\039\000\
\039\000\029\000\029\000\029\000\029\000\029\000\029\000\029\000\
\029\000\029\000\029\000\029\000\029\000\020\000\029\000\029\000\
\000\000\000\000\029\000\000\000\029\000\000\000\000\000\000\000\
\029\000\000\000\029\000\034\000\034\000\034\000\034\000\034\000\
\034\000\034\000\034\000\034\000\034\000\034\000\034\000\017\000\
\034\000\034\000\000\000\000\000\034\000\000\000\034\000\000\000\
\000\000\000\000\034\000\000\000\034\000\030\000\030\000\030\000\
\030\000\030\000\030\000\030\000\030\000\030\000\030\000\030\000\
\030\000\018\000\030\000\030\000\000\000\000\000\030\000\000\000\
\042\000\000\000\000\000\000\000\030\000\000\000\030\000\014\000\
\014\000\014\000\014\000\000\000\000\000\014\000\014\000\014\000\
\014\000\014\000\014\000\041\000\014\000\014\000\000\000\000\000\
\014\000\000\000\014\000\000\000\000\000\000\000\014\000\000\000\
\014\000\013\000\013\000\013\000\013\000\021\000\000\000\013\000\
\013\000\013\000\013\000\013\000\013\000\000\000\013\000\013\000\
\000\000\000\000\013\000\032\000\013\000\000\000\000\000\000\000\
\013\000\000\000\013\000\024\000\024\000\024\000\024\000\000\000\
\000\000\024\000\024\000\024\000\024\000\024\000\024\000\000\000\
\024\000\024\000\000\000\000\000\024\000\000\000\024\000\033\000\
\033\000\000\000\024\000\033\000\024\000\000\000\023\000\023\000\
\023\000\023\000\000\000\033\000\023\000\023\000\023\000\023\000\
\023\000\023\000\000\000\023\000\023\000\000\000\000\000\023\000\
\000\000\023\000\000\000\000\000\000\000\023\000\000\000\023\000\
\000\000\000\000\000\000\000\000\028\000\028\000\000\000\000\000\
\028\000\000\000\015\000\015\000\015\000\015\000\015\000\015\000\
\028\000\015\000\015\000\000\000\000\000\015\000\000\000\015\000\
\000\000\000\000\000\000\015\000\000\000\015\000\000\000\000\000\
\000\000\000\000\027\000\027\000\000\000\000\000\027\000\000\000\
\016\000\016\000\016\000\016\000\016\000\016\000\027\000\016\000\
\016\000\000\000\000\000\016\000\000\000\016\000\000\000\000\000\
\000\000\016\000\000\000\016\000\000\000\000\000\000\000\000\000\
\031\000\031\000\000\000\000\000\031\000\000\000\019\000\019\000\
\019\000\019\000\019\000\019\000\031\000\019\000\019\000\000\000\
\000\000\019\000\000\000\019\000\000\000\000\000\000\000\019\000\
\000\000\019\000\000\000\000\000\000\000\000\000\000\000\000\000\
\020\000\020\000\020\000\020\000\020\000\020\000\000\000\020\000\
\020\000\000\000\000\000\020\000\000\000\020\000\000\000\000\000\
\000\000\020\000\000\000\020\000\000\000\000\000\000\000\000\000\
\000\000\000\000\017\000\017\000\017\000\017\000\017\000\017\000\
\000\000\017\000\017\000\000\000\000\000\017\000\000\000\017\000\
\000\000\000\000\000\000\017\000\000\000\017\000\000\000\000\000\
\000\000\000\000\000\000\000\000\018\000\018\000\018\000\018\000\
\018\000\018\000\000\000\018\000\018\000\000\000\000\000\018\000\
\000\000\018\000\042\000\042\000\000\000\018\000\042\000\018\000\
\042\000\000\000\000\000\000\000\042\000\000\000\042\000\000\000\
\000\000\000\000\000\000\000\000\000\000\041\000\041\000\000\000\
\000\000\041\000\000\000\041\000\000\000\000\000\000\000\041\000\
\000\000\041\000\000\000\000\000\000\000\000\000\000\000\021\000\
\021\000\000\000\000\000\021\000\000\000\000\000\000\000\000\000\
\000\000\021\000\000\000\021\000\000\000\032\000\032\000\000\000\
\000\000\032\000\000\000\000\000\000\000\000\000\000\000\032\000\
\000\000\032\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\042\000\000\000\000\000\
\085\000\000\000\000\000\000\000\000\000\043\000\000\000\000\000\
\000\000\044\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\042\000\000\000\000\000\
\000\000\000\000\000\000\086\000\000\000\043\000\000\000\000\000\
\000\000\044\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\042\000\000\000\000\000\
\000\000\000\000\000\000\101\000\000\000\043\000\000\000\000\000\
\000\000\044\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\042\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\043\000\000\000\000\000\
\000\000\044\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\042\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\043\000\031\000\032\000\
\033\000\034\000\035\000\036\000\037\000\038\000\039\000\040\000\
\041\000\042\000"

let yycheck = "\024\001\
\000\000\001\001\002\001\003\001\020\001\030\001\001\000\023\001\
\007\000\008\000\009\000\010\000\024\001\029\001\011\001\014\000\
\009\001\010\001\020\001\020\001\020\001\029\001\026\001\022\001\
\020\001\011\001\026\001\011\001\020\001\029\001\000\000\029\001\
\031\000\032\000\033\000\034\000\035\000\036\000\037\000\038\000\
\039\000\040\000\041\000\042\000\043\000\044\000\024\001\020\001\
\027\001\048\000\049\000\050\000\000\000\011\001\013\000\022\001\
\077\000\016\000\013\000\255\255\000\000\016\000\005\001\006\001\
\007\001\008\001\009\001\010\001\027\000\255\255\255\255\255\255\
\027\000\072\000\000\001\001\001\002\001\003\001\004\001\005\001\
\079\000\007\001\255\255\255\255\083\000\255\255\085\000\086\000\
\047\000\088\000\000\000\017\001\047\000\092\000\020\001\021\001\
\001\001\002\001\003\001\025\001\255\255\100\000\101\000\029\001\
\030\001\000\001\001\001\002\001\003\001\004\001\005\001\255\255\
\007\001\255\255\255\255\020\001\000\000\001\001\002\001\003\001\
\255\255\026\001\017\001\255\255\029\001\020\001\021\001\255\255\
\255\255\255\255\025\001\255\255\255\255\255\255\029\001\255\255\
\020\001\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
\255\255\029\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\024\001\255\255\255\255\
\000\000\028\001\255\255\030\001\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\024\001\
\255\255\255\255\000\000\028\001\255\255\030\001\005\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\024\001\255\255\255\255\000\000\028\001\255\255\030\001\
\005\001\006\001\007\001\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\255\255\018\001\255\255\255\255\
\255\255\255\255\255\255\024\001\255\255\255\255\000\000\028\001\
\255\255\255\255\255\255\255\255\255\255\000\000\255\255\255\255\
\255\255\001\001\002\001\003\001\255\255\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\000\000\018\001\019\001\020\001\255\255\022\001\255\255\
\024\001\255\255\026\001\255\255\028\001\029\001\030\001\001\001\
\002\001\003\001\000\000\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\000\000\
\018\001\019\001\020\001\255\255\022\001\255\255\024\001\255\255\
\026\001\255\255\028\001\029\001\030\001\001\001\002\001\003\001\
\000\000\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\000\000\018\001\019\001\
\020\001\255\255\022\001\255\255\024\001\255\255\255\255\255\255\
\028\001\029\001\030\001\001\001\002\001\003\001\000\000\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\000\000\018\001\019\001\020\001\255\255\
\022\001\255\255\024\001\255\255\255\255\255\255\028\001\029\001\
\030\001\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\000\000\018\001\019\001\
\255\255\255\255\022\001\255\255\024\001\255\255\255\255\255\255\
\028\001\255\255\030\001\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\000\000\
\018\001\019\001\255\255\255\255\022\001\255\255\024\001\255\255\
\255\255\255\255\028\001\255\255\030\001\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\000\000\018\001\019\001\255\255\255\255\022\001\255\255\
\000\000\255\255\255\255\255\255\028\001\255\255\030\001\005\001\
\006\001\007\001\008\001\255\255\255\255\011\001\012\001\013\001\
\014\001\015\001\016\001\000\000\018\001\019\001\255\255\255\255\
\022\001\255\255\024\001\255\255\255\255\255\255\028\001\255\255\
\030\001\005\001\006\001\007\001\008\001\000\000\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\255\255\018\001\019\001\
\255\255\255\255\022\001\000\000\024\001\255\255\255\255\255\255\
\028\001\255\255\030\001\005\001\006\001\007\001\008\001\255\255\
\255\255\011\001\012\001\013\001\014\001\015\001\016\001\255\255\
\018\001\019\001\255\255\255\255\022\001\255\255\024\001\018\001\
\019\001\255\255\028\001\022\001\030\001\255\255\005\001\006\001\
\007\001\008\001\255\255\030\001\011\001\012\001\013\001\014\001\
\015\001\016\001\255\255\018\001\019\001\255\255\255\255\022\001\
\255\255\024\001\255\255\255\255\255\255\028\001\255\255\030\001\
\255\255\255\255\255\255\255\255\018\001\019\001\255\255\255\255\
\022\001\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\030\001\018\001\019\001\255\255\255\255\022\001\255\255\024\001\
\255\255\255\255\255\255\028\001\255\255\030\001\255\255\255\255\
\255\255\255\255\018\001\019\001\255\255\255\255\022\001\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\030\001\018\001\
\019\001\255\255\255\255\022\001\255\255\024\001\255\255\255\255\
\255\255\028\001\255\255\030\001\255\255\255\255\255\255\255\255\
\018\001\019\001\255\255\255\255\022\001\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\030\001\018\001\019\001\255\255\
\255\255\022\001\255\255\024\001\255\255\255\255\255\255\028\001\
\255\255\030\001\255\255\255\255\255\255\255\255\255\255\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\018\001\
\019\001\255\255\255\255\022\001\255\255\024\001\255\255\255\255\
\255\255\028\001\255\255\030\001\255\255\255\255\255\255\255\255\
\255\255\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\255\255\018\001\019\001\255\255\255\255\022\001\255\255\024\001\
\255\255\255\255\255\255\028\001\255\255\030\001\255\255\255\255\
\255\255\255\255\255\255\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\255\255\018\001\019\001\255\255\255\255\022\001\
\255\255\024\001\018\001\019\001\255\255\028\001\022\001\030\001\
\024\001\255\255\255\255\255\255\028\001\255\255\030\001\255\255\
\255\255\255\255\255\255\255\255\255\255\018\001\019\001\255\255\
\255\255\022\001\255\255\024\001\255\255\255\255\255\255\028\001\
\255\255\030\001\255\255\255\255\255\255\255\255\255\255\018\001\
\019\001\255\255\255\255\022\001\255\255\255\255\255\255\255\255\
\255\255\028\001\255\255\030\001\255\255\018\001\019\001\255\255\
\255\255\022\001\255\255\255\255\255\255\255\255\255\255\028\001\
\255\255\030\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\019\001\255\255\255\255\255\255\255\255\024\001\255\255\255\255\
\255\255\028\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\255\255\255\255\255\255\022\001\255\255\024\001\255\255\255\255\
\255\255\028\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\255\255\255\255\255\255\022\001\255\255\024\001\255\255\255\255\
\255\255\028\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\024\001\255\255\255\255\
\255\255\028\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\024\001\005\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001"

let yynames_const = "\
  NOT\000\
  MINUS\000\
  PLUS\000\
  MINUS_DOT\000\
  PLUS_DOT\000\
  AST_DOT\000\
  SLASH_DOT\000\
  EQUAL\000\
  LESS_GREATER\000\
  LESS_EQUAL\000\
  GREATER_EQUAL\000\
  LESS\000\
  GREATER\000\
  IF\000\
  THEN\000\
  ELSE\000\
  LET\000\
  IN\000\
  REC\000\
  COMMA\000\
  ARRAY_CREATE\000\
  DOT\000\
  LESS_MINUS\000\
  SEMICOLON\000\
  LPAREN\000\
  RPAREN\000\
  EOF\000\
  "

let yynames_block = "\
  BOOL\000\
  INT\000\
  FLOAT\000\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'simple_body) in
    Obj.repr(
# 63 "parser.mly"
              ( (symbol_range (), _1) )
# 428 "parser.ml"
               : 'simple_exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Syntax.t) in
    Obj.repr(
# 67 "parser.mly"
    ( snd _2 )
# 435 "parser.ml"
               : 'simple_body))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "parser.mly"
    ( Unit )
# 441 "parser.ml"
               : 'simple_body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 71 "parser.mly"
    ( Bool(_1) )
# 448 "parser.ml"
               : 'simple_body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 73 "parser.mly"
    ( Int(_1) )
# 455 "parser.ml"
               : 'simple_body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 75 "parser.mly"
    ( Float(_1) )
# 462 "parser.ml"
               : 'simple_body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Id.t) in
    Obj.repr(
# 77 "parser.mly"
    ( Var(_1) )
# 469 "parser.ml"
               : 'simple_body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'simple_exp) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Syntax.t) in
    Obj.repr(
# 79 "parser.mly"
    ( Get(_1, _4) )
# 477 "parser.ml"
               : 'simple_body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'body) in
    Obj.repr(
# 82 "parser.mly"
       ( (symbol_range (), _1) )
# 484 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'simple_body) in
    Obj.repr(
# 86 "parser.mly"
    ( _1 )
# 491 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 89 "parser.mly"
    ( Not(_2) )
# 498 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 92 "parser.mly"
    ( match _2 with
    | (_, Float(f)) -> Float(-.f) (* -1.23などは型エラーではないので別扱い *)
    | e -> Neg(e) )
# 507 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 96 "parser.mly"
    ( Add(_1, _3) )
# 515 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 98 "parser.mly"
    ( Sub(_1, _3) )
# 523 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 100 "parser.mly"
    ( Eq(_1, _3) )
# 531 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 102 "parser.mly"
    ( Not(symbol_range (), Eq(_1, _3)) )
# 539 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 104 "parser.mly"
    ( Not(symbol_range (), LE(_3, _1)) )
# 547 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 106 "parser.mly"
    ( Not(symbol_range (), LE(_1, _3)) )
# 555 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 108 "parser.mly"
    ( LE(_1, _3) )
# 563 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 110 "parser.mly"
    ( LE(_3, _1) )
# 571 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : Syntax.t) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 113 "parser.mly"
    ( If(_2, _4, _6) )
# 580 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 116 "parser.mly"
    ( FNeg(_2) )
# 587 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 118 "parser.mly"
    ( FAdd(_1, _3) )
# 595 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 120 "parser.mly"
    ( FSub(_1, _3) )
# 603 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 122 "parser.mly"
    ( FMul(_1, _3) )
# 611 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 124 "parser.mly"
    ( FDiv(_1, _3) )
# 619 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : Id.t) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 127 "parser.mly"
    ( Let(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 4), addtyp _2, _4, _6) )
# 628 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'fundef) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 130 "parser.mly"
    ( LetRec(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 3), _3, _5) )
# 636 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'simple_exp) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'actual_args) in
    Obj.repr(
# 133 "parser.mly"
    ( App(_1, _2) )
# 644 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'elems) in
    Obj.repr(
# 136 "parser.mly"
    ( Tuple(_1) )
# 651 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'pat) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 138 "parser.mly"
    ( LetTuple(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 6), _3, _6, _8) )
# 660 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : 'simple_exp) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : Syntax.t) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 140 "parser.mly"
    ( Put(_1, _4, _7) )
# 669 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 142 "parser.mly"
    ( Let(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 1), (Id.gentmp Type.Unit, Type.Unit), _1, _3) )
# 677 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'simple_exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'simple_exp) in
    Obj.repr(
# 145 "parser.mly"
    ( Array(_2, _3) )
# 685 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    Obj.repr(
# 147 "parser.mly"
    ( Printf.printf "Parse error at %s\n" (H.show_range (symbol_range ()));
      exit 1 )
# 692 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : Id.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'formal_args) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 152 "parser.mly"
    ( { name = addtyp _1; args = _2; body = _4 } )
# 701 "parser.ml"
               : 'fundef))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Id.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'formal_args) in
    Obj.repr(
# 156 "parser.mly"
    ( addtyp _1 :: _2 )
# 709 "parser.ml"
               : 'formal_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Id.t) in
    Obj.repr(
# 158 "parser.mly"
    ( [addtyp _1] )
# 716 "parser.ml"
               : 'formal_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'actual_args) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'simple_exp) in
    Obj.repr(
# 163 "parser.mly"
    ( _1 @ [_2] )
# 724 "parser.ml"
               : 'actual_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'simple_exp) in
    Obj.repr(
# 166 "parser.mly"
    ( [_1] )
# 731 "parser.ml"
               : 'actual_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'elems) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 170 "parser.mly"
    ( _1 @ [_3] )
# 739 "parser.ml"
               : 'elems))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 172 "parser.mly"
    ( [_1; _3] )
# 747 "parser.ml"
               : 'elems))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'pat) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Id.t) in
    Obj.repr(
# 176 "parser.mly"
    ( _1 @ [addtyp _3] )
# 755 "parser.ml"
               : 'pat))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Id.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Id.t) in
    Obj.repr(
# 178 "parser.mly"
    ( [addtyp _1; addtyp _3] )
# 763 "parser.ml"
               : 'pat))
(* Entry exp *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let exp (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Syntax.t)
