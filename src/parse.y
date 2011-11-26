%token NAME
%token RSCREF
%token ROCKET
%token CLASS
%token CASE
%token STRING_LITERAL INT_LITERAL FLOAT_LITERAL
%token DEFAULT
%token VARIABLE
%token IF
%token ELSE
%token ELSIF
%token DEFINE
%token BEFORE
%token NOTIFY
%token TRUE FALSE AND OR
%token IN EQ LTE GT GTE NE

%left OR
%left AND
%left IN EQ '<' LTE '>' GTE NE
%left '+' '-'
%left '*' '/' '%'
%left '!'
%left '['

%{
#include <stdio.h>
#include <stdlib.h>

int yyerror(char *s);
extern int yylex();
%}

%%

input:
    opt_statements_and_declarations

opt_statements_and_declarations:
    /* empty */
    | statements_and_declarations

statements_and_declarations:
    statement_or_declaration
    | statements_and_declarations statement_or_declaration

statement_or_declaration:
    resource
    | assignment
    | casestatement
    | ifstatement
    | definition
    | class
    | chain

resource:
    NAME '{' resourceinstances endsemi '}'

resourceinstances:
    resourceinst
    | resourceinstances ';' resourceinst

resourceinst:
    expr ':' params endcomma

params:
    /* empty */
    | param
    | params ',' param

param:
    NAME ROCKET expr

literal:
    STRING_LITERAL
    | INT_LITERAL
    | FLOAT_LITERAL
    | VARIABLE
    | TRUE
    | FALSE

expr:
    literal
    | array
    | hash
    | '(' expr ')'
    | '-' expr
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | expr '%' expr
    | expr AND expr
    | expr OR expr
    | expr IN expr
    | expr EQ expr
    | expr '<' expr
    | expr LTE expr
    | expr '>' expr
    | expr GTE expr
    | expr NE expr
    | '!' expr
    | expr '[' expr ']'

expressions:
    expr
    | expressions ',' expr

array:
    '[' expressions endcomma ']'
    | '[' ']'

hash:
    '{' hashitems endcomma '}'
    | '{' '}'

hashitems:
    hashitem
    | hashitems ',' hashitem

hashitem:
    expr ROCKET expr

endcomma:
    /* empty */
    | ','

endsemi:
    /* empty */
    | ';'

assignment:
    VARIABLE '=' expr

casestatement:
    CASE expr '{' caseopts '}'

caseopts:
    caseopt
    | caseopts caseopt

caseopt:
    casevalues ':' '{' opt_statements_and_declarations '}'

casevalues:
    caselvalue
    | casevalues ',' caselvalue

caselvalue:
    expr
    | DEFAULT

ifstatement:
    IF expr '{' opt_statements_and_declarations '}' else

else:
    /* empty */
    | ELSIF expr '{' opt_statements_and_declarations '}' else
    | ELSE '{' opt_statements_and_declarations '}'

definition:
    DEFINE NAME argumentlist '{' opt_statements_and_declarations '}'

argumentlist:
    /* empty */
    | '(' ')'
    | '(' arguments endcomma ')'

arguments:
    argument
    | arguments ',' argument

argument:
    VARIABLE
    | VARIABLE '=' expr

class:
    CLASS NAME argumentlist '{' opt_statements_and_declarations '}'

chain:
    chain_node edge chain_node
    | chain edge chain_node

chain_node:
    resourceref

resourceref:
    RSCREF '[' expr ']'

edge:
    BEFORE
    | NOTIFY

%%

extern char *yytext;
extern int yylineno;

int yyerror(char *s) {
    fprintf(stderr, "ERROR: %s at symbol %s on line %i\n", s, yytext, yylineno);
    exit(1);
}
