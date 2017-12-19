%{
open Syntax
let addtyp x = (x, Type.gentyp ())

(* MATSUSHITA: added functions *)

let symbol_range () = Some (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())

let just body = None, body
let letint x e e' = just @@ Let (None, (x, Type.Int), e, e')
let letfloat x e e' = just @@ Let (None, (x, Type.Float), e, e')
let (&!) e n = just @@ AndI(e, n)
let var x = just @@ Var x
let int n = just @@ Int n
let float a = just @@ Float a
let ftoi e = just @@ FToI e
let itof e = just @@ IToF e
let (+!) e e' = just @@ FAdd(e, e')
let (-!) e e' = just @@ FSub(e, e')
let ( *!) e e' = just @@ FMul(e, e')
let (/!) e e' = just @@ FDiv(e, e')

let cos e =
  letfloat "x" e @@
  letfloat "xx" (var "x" *! var "x") @@
  letfloat "t2" (var "xx" /! float 2.) @@
  letfloat "t4" (var "t2" *! var "xx" /! float 12.) @@
  letfloat "t6" (var "t4" *! var "xx" /! float 30.) @@
  letfloat "t8" (var "t6" *! var "xx" /! float 56.) @@
  letfloat "t10" (var "t8" *! var "xx" /! float 90.) @@
  float 1. -! var "t2" +! var "t4" -! var "t6" +! var "t8" -! var "t10"

let pi = float 3.1415927

let sin e =
  letfloat "x" e @@
  letint "n" (ftoi (var "x" /! pi)) @@
  (float 1. -! itof (var "n" &! 1) *! float 2.) *!
    cos (var "x" -! itof (var "n") *! pi -! pi /! float 2.)

let tan e =
  letfloat "x" e @@
  letfloat "xx" (var "x" *! var "x") @@
  letfloat "t3" (var "x" *! var "xx" /! float 3.) @@
  letfloat "t5" (var "t3" *! var "xx" *! (float 2. /! float 5.)) @@
  letfloat "t7" (var "t5" *! var "xx" *! (float 17. /! float 42.)) @@
  letfloat "t9" (var "t7" *! var "xx" *! (float 62. /! float 153.)) @@
  var "x" +! var "t3" +! var "t5" +! var "t7" +! var "t9"

let atan e =
  letfloat "x" e @@
  letfloat "t1" ((var "x" -! float 2.) /! float 5.) @@
  letfloat "t2" ((var "t1" *! var "t1" *! float 2.)) @@
  letfloat "t3" ((var "t2" *! var "t1" *! (float 11. /! float 6.))) @@
  letfloat "t4" ((var "t3" *! var "t1" *! (float 18. /! float 11.))) @@
  letfloat "t5" ((var "t4" *! var "t1" *! (float 41. /! float 30.))) @@
  float 1.10714872 +! var "t1" -! var "t2" +! var "t3" -! var "t4" +! var "t5"

%}

%token <bool> BOOL
%token <int> INT
%token <float> FLOAT
%token NOT PLUS MINUS AST SLASH
%token PLUS_DOT MINUS_DOT AST_DOT SLASH_DOT
%token EQUAL LESS_GREATER LESS_EQUAL GREATER_EQUAL LESS GREATER
%token IF THEN ELSE
%token <Id.t> IDENT
%token LET IN REC
%token COMMA
%token ARRAY_CREATE DOT LESS_MINUS
%token <Id.t> UIDENT
%token OPEN SEMISEMI DELIM
%token FUN MINUS_GREATER
%token SEMICOLON
%token LPAREN RPAREN
%token EOF
/* MATSUSHITA: added tokens */
%token XOR
%token FISZERO FLESS FISPOS FISNEG
%token FNEG FABS FHALF FSQR FLOOR FLOATOFINT INTOFFLOAT SQRT COS SIN TAN ATAN
%token READINT READFLOAT PRINTCHAR PRINTINT PRINTFLOAT
%token PLUS_AT MINUS_BANG

%nonassoc IN
%right prec_let
%right SEMICOLON
%right prec_if
%right LESS_MINUS
%nonassoc prec_tuple
%left COMMA
%left EQUAL LESS_GREATER LESS GREATER LESS_EQUAL GREATER_EQUAL
%left PLUS MINUS PLUS_DOT MINUS_DOT PLUS_AT
%left AST SLASH AST_DOT SLASH_DOT
%right prec_unary_minus
%left prec_app
%left DOT

%type <Syntax.t> prog
%start prog

%%

/* MATSUSHITA: added prog and glob */

prog:
| OPEN UIDENT SEMISEMI glob { $4 }
| exp { $1 }

glob:
| LET IDENT EQUAL exp glob
    %prec prec_let
    { symbol_range (), Let(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 4),
        addtyp $2, $4, $5) }
| DELIM exp { $2 }

/* MATSUSHITA: added simmple_body and body, altering simple_exp and exp */

simple_exp:
| LPAREN exp RPAREN
    { $2 }
| LPAREN RPAREN
    { symbol_range (), Unit }
| BOOL
    { symbol_range (), Bool($1) }
| INT
    { symbol_range (), Int($1) }
| FLOAT
    { symbol_range (), Float($1) }
| IDENT
    { symbol_range (), Var($1) }
| simple_exp DOT LPAREN exp RPAREN
    { symbol_range (), Get($1, $4) }

exp:
| simple_exp
    { $1 }
| NOT simple_exp
    %prec prec_app
    { symbol_range (), Not($2) }
| XOR simple_exp simple_exp
    %prec prec_app
    { symbol_range (), Xor($2, $3) }
| FISZERO simple_exp
    %prec prec_app
    { symbol_range (), FEq($2, float 0.) }
| FLESS simple_exp simple_exp
    %prec prec_app
    { symbol_range (), FLT($2, $3) }
| FISPOS simple_exp
    %prec prec_app
    { symbol_range (), FLT(float 0., $2) }
| FISNEG simple_exp
    %prec prec_app
    { symbol_range (), FLT($2, float  0.) }
| FNEG simple_exp
    %prec prec_app
    { symbol_range (), FNeg($2) }
| FHALF simple_exp
    %prec prec_app
    { symbol_range (), FMul($2, float 0.5) }
| FSQR simple_exp
    %prec prec_app
    { let tmp = Id.gentmp () in
      symbol_range (), Let(None, addtyp tmp, $2,
        (symbol_range (), FMul(var tmp, var tmp))) }
| FABS simple_exp
    %prec prec_app
    { symbol_range (), FAbs($2) }
| FLOOR simple_exp
    %prec prec_app
    { symbol_range (), FFloor($2) }
| FLOATOFINT simple_exp
    %prec prec_app
    { symbol_range (), IToF($2) }
| INTOFFLOAT simple_exp
    %prec prec_app
    { symbol_range (), FToI($2) }
| SQRT simple_exp
    %prec prec_app
    { symbol_range (), FSqrt($2) }
| COS simple_exp
    %prec prec_app
    { symbol_range (), snd @@ cos $2 }
| SIN simple_exp
    %prec prec_app
    { symbol_range (), snd @@ sin $2 }
| TAN simple_exp
    %prec prec_app
    { symbol_range (), snd @@ tan $2 }
| ATAN simple_exp
    %prec prec_app
    { symbol_range (), snd @@ atan $2 }
| READINT simple_exp
    %prec prec_app
    { symbol_range (), Read }
| READFLOAT simple_exp
    %prec prec_app
    { symbol_range (), FRead }
/* MATSUSHITA: ignore print_char */
| PRINTCHAR simple_exp
    %prec prec_app
    { symbol_range (), Unit }
| PRINTINT simple_exp
    %prec prec_app
    { symbol_range (), Write($2) }
| PRINTFLOAT simple_exp
    %prec prec_app
    { symbol_range (), FWrite($2) }
| MINUS exp
    %prec prec_unary_minus
    { symbol_range (), match $2 with
    | _, Float f -> Float(-.f)
    | e -> Neg e }
| exp PLUS exp
    { symbol_range (), Add($1, $3) }
| exp MINUS exp
    { symbol_range (), Sub($1, $3) }
| exp AST INT
    { assert($3 = 4);
      symbol_range (), SllI($1, 2) }
| exp SLASH INT
    { assert($3 = 2);
      symbol_range (), SraI($1, 1) }
| exp EQUAL exp
    { symbol_range (), Eq($1, $3) }
| exp LESS_GREATER exp
    { symbol_range (), Not(symbol_range (), Eq($1, $3)) }
| exp LESS exp
    { symbol_range (), LT($1, $3) }
| exp GREATER exp
    { symbol_range (), LT($3, $1) }
| exp LESS_EQUAL exp
    { symbol_range (), Not(symbol_range (), LT($3, $1)) }
| exp GREATER_EQUAL exp
    { symbol_range (), Not(symbol_range (), LT($1, $3)) }
| IF exp THEN exp ELSE exp
    %prec prec_if
    { symbol_range (), If($2, $4, $6) }
| MINUS_DOT exp
    %prec prec_unary_minus
    { symbol_range (), FNeg($2) }
| exp PLUS_DOT exp
    { symbol_range (), FAdd($1, $3) }
| exp MINUS_DOT exp
    { symbol_range (), FSub($1, $3) }
| exp AST_DOT exp
    { symbol_range (), FMul($1, $3) }
| exp SLASH_DOT exp
    { symbol_range (), FDiv($1, $3) }
/* MATSUSHITA: ignore true and false */
| LET BOOL EQUAL exp IN exp
    { $6 }
| LET IDENT EQUAL exp IN exp
    %prec prec_let
    { (* MATSUSHITA: added range *)
      if snd $6 = Int 0 then $4 else
      symbol_range (), Let(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 4),
        addtyp $2, $4, $6) }
/* MATUSHITA: ignore xor and tan */
| LET REC XOR formal_args EQUAL exp IN exp
    %prec prec_let
    { $8 }
| LET REC TAN formal_args EQUAL exp IN exp
    %prec prec_let
    { $8 }
| LET REC fundef IN exp
    %prec prec_let
    { (* MATSUSHITA: added range *)
      symbol_range (), LetRec(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 3),
        $3, $5) }
/* MATUSHITA: added lambda expression */
| FUN formal_args MINUS_GREATER exp
    %prec prec_let
    {
      let f = Id.gentmp () in
      symbol_range (), LetRec(symbol_range (),
        { name = addtyp f; args = $2; body = $4 }, (symbol_range (), Var f))
    }
| simple_exp actual_args
    %prec prec_app
    { symbol_range (), App($1, $2) }
| elems
    %prec prec_tuple
    { symbol_range (), Tuple($1) }
| LET LPAREN pat RPAREN EQUAL exp IN exp
    { (* MATSUSHITA: added range *)
      symbol_range (), LetTuple(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 6),
        $3, $6, $8) }
| simple_exp DOT LPAREN exp RPAREN LESS_MINUS exp
    { symbol_range (), Put($1, $4, $7) }
| exp SEMICOLON exp
    { symbol_range (), Let(None, (Id.genunit (), Type.Unit), $1, $3) }
| exp SEMICOLON
    { symbol_range (), Let(None, (Id.genunit (), Type.Unit), $1, (None, Unit)) }
| ARRAY_CREATE simple_exp simple_exp
    %prec prec_app
    { symbol_range (), Array($2, $3) }
/* MATUSHITA: added polymorphic operators */
| exp PLUS_AT exp
    { symbol_range (), IFAdd($1, $3) }
| MINUS_BANG exp
    %prec prec_unary_minus
    { symbol_range (), NotNeg($2) }
| error
    { Printf.printf "Parse error at %s\n" (H.show_range (symbol_range ()));
      exit 1 }

fundef:
| IDENT formal_args EQUAL exp
    { { name = addtyp $1; args = $2; body = $4 } }

formal_args:
| IDENT formal_args
    { addtyp $1 :: $2 }
| IDENT
    { [addtyp $1] }

actual_args:
| actual_args simple_exp
    %prec prec_app
    { $1 @ [$2] }
| simple_exp
    %prec prec_app
    { [$1] }

elems:
| elems COMMA exp
    { $1 @ [$3] }
| exp COMMA exp
    { [$1; $3] }

pat:
| pat COMMA IDENT
    { $1 @ [addtyp $3] }
| IDENT COMMA IDENT
    { [addtyp $1; addtyp $3] }
