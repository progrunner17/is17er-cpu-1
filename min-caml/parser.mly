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
%token XOR
%token AND
%token FISZERO
%token FLESS
%token FISPOS
%token FISNEG
%token FNEG
%token FABS
%token FHALF
%token FSQR
%token FLOOR
%token FLOATOFINT
%token INTOFFLOAT
%token SQRT
%token COS
%token SIN
%token TAN
%token ATAN
%token PLUS
%token MINUS
%token AST
%token SLASH
%token PLUS_DOT
%token MINUS_DOT
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

exp: /* (* ���̤μ� (caml2html: parser_exp) *) */
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
    { symbol_range (), FEq($2, (None, Float(0.))) }
| FLESS simple_exp simple_exp
    %prec prec_app
    { symbol_range (), FLT($2, $3) }
| FISPOS simple_exp
    %prec prec_app
    { symbol_range (), FLT((None, Float(0.)), $2) }
| FISNEG simple_exp
    %prec prec_app
    { symbol_range (), FLT($2, (None, Float(0.))) }
| FNEG simple_exp
    %prec prec_app
    { symbol_range (), FNeg($2) }
| FHALF simple_exp
    %prec prec_app
    { symbol_range (), FMul($2, (None, Float(0.5))) }
| FSQR simple_exp
    %prec prec_app
    { let tmp = Id.gentmp () in
      symbol_range (), Let(None, addtyp tmp, $2,
        (symbol_range (), FMul((None, Var(tmp)), (None, Var(tmp))))) }
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
    { symbol_range (), FCos($2) }
| SIN simple_exp
    %prec prec_app
    { symbol_range (), FSin($2) }
| TAN simple_exp
    %prec prec_app
    { symbol_range (), FSin($2) }
| ATAN simple_exp
    %prec prec_app
    { symbol_range (), FAtan($2) }
| MINUS exp
    %prec prec_unary_minus
    { symbol_range (), match $2 with
    | _, Float f -> Float(-.f) (* -1.23�ʤɤϷ����顼�ǤϤʤ��Τ��̰��� *)
    | e -> Neg e }
| exp PLUS exp /* (* ­������ʸ���Ϥ���롼�� (caml2html: parser_add) *) */
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
| LET BOOL EQUAL exp IN exp
    { $6 }
| LET IDENT EQUAL exp IN exp
    %prec prec_let
    { (* MATSUSHITA: added range *)
      if snd $6 = Int 0 then $4 else
      symbol_range (), Let(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 4), addtyp $2, $4, $6) }
| LET REC XOR formal_args EQUAL exp IN exp
    { $8 }
| LET REC TAN formal_args EQUAL exp IN exp
    { $8 }
| LET REC fundef IN exp
    %prec prec_let
    { (* MATSUSHITA: added range *)
      symbol_range (), LetRec(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 3), $3, $5) }
| simple_exp actual_args
    %prec prec_app
    { symbol_range (), App($1, $2) }
| elems
    %prec prec_tuple
    { symbol_range (), Tuple($1) }
| LET LPAREN pat RPAREN EQUAL exp IN exp
    { (* MATSUSHITA: added range *)
      symbol_range (), LetTuple(Some (Parsing.symbol_start_pos (), Parsing.rhs_end_pos 6), $3, $6, $8) }
| simple_exp DOT LPAREN exp RPAREN LESS_MINUS exp
    { symbol_range (), Put($1, $4, $7) }
| exp SEMICOLON exp
    { symbol_range (), Let(None, (Id.genunit (), Type.Unit), $1, $3) }
| exp SEMICOLON
    { symbol_range (), Let(None, (Id.genunit (), Type.Unit), $1, (None, Unit)) }
| ARRAY_CREATE simple_exp simple_exp
    %prec prec_app
    { symbol_range (), Array($2, $3) }
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
