%{
(* parser�����Ѥ����ѿ����ؿ������ʤɤ���� *)
open Syntax
let addtyp x = (x, Type.gentyp ())
(* MATSUSHITA: added symbol_range function *)
let symbol_range () = Some (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())
%}

/* (* �����ɽ���ǡ���������� (caml2html: parser_token) *) */
%token <bool> BOOL
%token <int> INT
%token <float> FLOAT
%token NOT
%token MINUS
%token PLUS
%token MINUS_DOT
%token PLUS_DOT
%token AST_DOT
%token SLASH_DOT
%token EQUAL
%token LESS_GREATER
%token LESS_EQUAL
%token GREATER_EQUAL
%token LESS
%token GREATER
%token IF
%token THEN
%token ELSE
%token <Id.t> IDENT
%token LET
%token IN
%token REC
%token COMMA
%token ARRAY_CREATE
%token DOT
%token LESS_MINUS
%token SEMICOLON
%token LPAREN
%token RPAREN
%token EOF

/* (* ͥ���̤�associativity��������㤤������⤤���ء� (caml2html: parser_prior) *) */
%nonassoc IN
%right prec_let
%right SEMICOLON
%right prec_if
%right LESS_MINUS
%nonassoc prec_tuple
%left COMMA
%left EQUAL LESS_GREATER LESS GREATER LESS_EQUAL GREATER_EQUAL
%left PLUS MINUS PLUS_DOT MINUS_DOT
%left AST_DOT SLASH_DOT
%right prec_unary_minus
%left prec_app
%left DOT

/* (* ���ϵ������� *) */
%type <Syntax.t> exp
%start exp

%%

/* MATSUSHITA: added simmple_body and body, altering simple_exp and exp */

simple_exp: /* (* ��̤�Ĥ��ʤ��Ƥ�ؿ��ΰ����ˤʤ�뼰 (caml2html: parser_simple) *) */
| simple_body { (symbol_range (), $1) }

simple_body:
| LPAREN exp RPAREN
    { snd $2 }
| LPAREN RPAREN
    { Unit }
| BOOL
    { Bool($1) }
| INT
    { Int($1) }
| FLOAT
    { Float($1) }
| IDENT
    { Var($1) }
| simple_exp DOT LPAREN exp RPAREN
    { Get($1, $4) }

exp: /* (* ���̤μ� (caml2html: parser_exp) *) */
| body { (symbol_range (), $1) }

body:
| simple_body
    { $1 }
| NOT exp
    %prec prec_app
    { Not($2) }
| MINUS exp
    %prec prec_unary_minus
    { match $2 with
    | (_, Float(f)) -> Float(-.f) (* -1.23�ʤɤϷ����顼�ǤϤʤ��Τ��̰��� *)
    | e -> Neg(e) }
| exp PLUS exp /* (* ­������ʸ���Ϥ���롼�� (caml2html: parser_add) *) */
    { Add($1, $3) }
| exp MINUS exp
    { Sub($1, $3) }
| exp EQUAL exp
    { Eq($1, $3) }
| exp LESS_GREATER exp
    { Not(symbol_range (), Eq($1, $3)) }
| exp LESS exp
    { Not(symbol_range (), LE($3, $1)) }
| exp GREATER exp
    { Not(symbol_range (), LE($1, $3)) }
| exp LESS_EQUAL exp
    { LE($1, $3) }
| exp GREATER_EQUAL exp
    { LE($3, $1) }
| IF exp THEN exp ELSE exp
    %prec prec_if
    { If($2, $4, $6) }
| MINUS_DOT exp
    %prec prec_unary_minus
    { FNeg($2) }
| exp PLUS_DOT exp
    { FAdd($1, $3) }
| exp MINUS_DOT exp
    { FSub($1, $3) }
| exp AST_DOT exp
    { FMul($1, $3) }
| exp SLASH_DOT exp
    { FDiv($1, $3) }
| LET IDENT EQUAL exp IN exp
    %prec prec_let
    { (* MATSUSHITA: added range *)
      Let(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 4), addtyp $2, $4, $6) }
| LET REC fundef IN exp
    %prec prec_let
    { (* MATSUSHITA: added range *)
      LetRec(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 3), $3, $5) }
| simple_exp actual_args
    %prec prec_app
    { App($1, $2) }
| elems
    %prec prec_tuple
    { Tuple($1) }
| LET LPAREN pat RPAREN EQUAL exp IN exp
    { (* MATSUSHITA: added range *)
      LetTuple(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 6), $3, $6, $8) }
| simple_exp DOT LPAREN exp RPAREN LESS_MINUS exp
    { Put($1, $4, $7) }
| exp SEMICOLON exp
    { Let(None, (Id.genunit (), Type.Unit), $1, $3) }
| ARRAY_CREATE simple_exp simple_exp
    %prec prec_app
    { Array($2, $3) }
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